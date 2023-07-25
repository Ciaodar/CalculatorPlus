const redis = require('redis');

const redisClient = redis.createClient("rediss://default:AVNS_qF7ktwaXcTDXER13_kB@db-redis-nyc1-26286-do-user-14375429-0.b.db.ondigitalocean.com:25061");
const Input = require('../models/inputschema');

const updateCache = async (id) => {
  const cacheKey = `input_${id}`;
  try {
    const found = await Input.find({userId:id});
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

  }catch (error) {
    return `Sunucu hatası ${error}`;
  }
};

async function getDataFromCache(id) {
  const cacheKey = `input_${id}`;
  try {
    const cachedData = await new Promise((resolve, reject) => {
    redisClient.get(cacheKey, (err, data) => {
      if (err) reject(err);
        resolve(data);
      });
     });
      if (cachedData !== null) {
       console.log("Data found in cache:", cachedData);
       return cachedData;
      }else {
        const cachingData = await updateCache(id);
        return cachingData;
      }
  }catch (error) {
    console.log("Hata: "+error);
  }
}

const invalidateCache = async (id) => {
  const cacheKey = `input_${id}`;
  try{
    redisClient.del(cacheKey , (err , reply) => {
      if(err) {
        console.error("hata4 "+err);
      } else {
        console.log('Önbellekten veri silindi. ${cacheKey}');
      }
    });
  }
  catch (error) {
    console.error("Hata: "+error);
  }
};

module.exports = getDataFromCache;




