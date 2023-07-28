
const redis = require('redis');
const url = "redis://default:KFBzAD2VaXaBfWHXZykvg1oIbzOjuyLm@redis-16742.c55.eu-central-1-1.ec2.cloud.redislabs.com:16742";
const redisClient = redis.createClient({
  url: "redis://default:KFBzAD2VaXaBfWHXZykvg1oIbzOjuyLm@redis-16742.c55.eu-central-1-1.ec2.cloud.redislabs.com:16742"
});

const Input = require('../models/inputschema');

const updateCache = async (id) => {
  console.log("1");
  const cacheKey = `input_${id}`;
  try {
   const found = await Input.find({userId:id},{_id:0,Calculations:1});
    if (!found) {
      return "Veri bulunamadı";
    }
    const foundJson = JSON.stringify(found);
    redisClient.multi()    // Son 20 veriyi önbellekte saklar.
      .lpush('recentData', cacheKey)
      .ltrim('recentData', 0, 19)
      .set(cacheKey, foundJson , 'EX' , 120)
      .exec((err) => {
        if (err) {
          console.error(err);
        }
      });
      console.log("2");
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
      console.log("3");
      if (err) reject(err);
        resolve(data);
      });
     });
      if (cachedData !== null) {
        console.log("4");
       console.log("Data found in cache:", cachedData);
       const jason=JSON.parse(cachedData)
       return jason;
      }else {
        const cachingData = await updateCache(id);
        return cachingData;
        console.log("5");
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
        console.log("6");
        console.error("hata4 "+err);
      } else {
        console.log("7");
        console.log('Önbellekten veri silindi. ${cacheKey}');
      }
    });
  }
  catch (error) {
    console.error("Hata: "+error);
  }
};

module.exports = getDataFromCache;






