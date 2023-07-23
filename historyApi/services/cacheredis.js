const redis = require('redis');
const redisClient = redis.createClient();
const Input = require('../models/inputschema');



const updateCache = async (id) => {
  const cacheKey = `input_${id}`;
  try {
    const found = await Input.findById(id).exec();
    if (!found) {
      return "Veri bulunamadı";
    }

    const foundJson = JSON.stringify(found);

    redisClient.multi()    // Son 20 veriyi önbellekte saklar.
      .lpush('recentData', cacheKey)
      .ltrim('recentData', 0, 19)
      .set(cacheKey, foundJson)
      .exec((err) => {
        if (err) {
          console.error(err);
        }
      });

    return (found);
  } catch (error) {
    console.error(error);
    return 'Sunucu Hatası';
  }
};


async function getDataFromCache(id) {
  const cacheKey = `input_${id}`;
  try {
    const cachedData = await new Promise((resolve, reject) => {
      redisClient.get(cacheKey, (err, data) => {
        if (err) {
          console.error(err);
          reject(err);
        }
        resolve(data);
      });
    });



   if (cachedData) {
      return JSON.parse(cachedData);
    } else {
      const torouter = await updateCache(id);
      return torouter; // veya başka bir değer döndürebilirsiniz
    }
  } catch (error) {
    console.error(error);
    throw new Error("Sunucu Hatasi");
  }
}

const invalidateCache = async (id) => {
  const cacheKey = 'input_${id}';
  try{
    redisClient.del(cacheKey , (err , reply) => {
      if(err) {
        console.error(err);
      } else {
        console.log('Önbellekten veri silindi. ${cacheKey}');
      }
    });
  }
  catch (error) {
    console.error(error);
    throw new Error("Sunucu Hatasi");
  }
};



module.exports = getDataFromCache;




