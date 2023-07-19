const redis = require('redis');
const redisClient = redis.createClient();


    const updateCache = async (id) => {
        const cacheKey = `input_${id}`;
      try {
        const found = await Input.findById(id).exec();
        if (!found) {
          return res.status(404).send("Veri bulunamadı");
        }

        const foundJson = JSON.stringify(found);

        redisClient.multi()    // Son 20 veriyi önbellekte saklar.
          .lpush('recentData', cacheKey)
          .ltrim('recentData', 0, 19)
          .set(cacheKey, foundJson, 'EX')
          .exec((err) => {
            if (err) {
              console.error(err);
            }
          });

        return res.send(found);
      } catch (error) {
        console.error(error);
        return res.status(500).send('Sunucu Hatası');
      }
    };

    const isim = redisClient.get(cacheKey, async (err, cachedData) => {
      if (err) {
        console.error(err);
        return res.status(500).send("Sunucu Hatasi");
      }

      if (cachedData) {
        return res.send(JSON.parse(cachedData));
      }

      await updateCache();
    });
   
  
;

module.exports = isim;