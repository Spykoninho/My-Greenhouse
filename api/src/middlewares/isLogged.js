var jsonwebtoken = require("jsonwebtoken");

const isLogged = (req, res, next) => {
  try {
    let jwt = null;
    if (req.headers.authorization) {
      jwt = req.headers.authorization;
    } else if (req.headers.cookie) {
      let cookies = req.headers.cookie;
      cookies = cookies.split("; ");
      for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i].split("=");
        if (cookie[0] == "MyGreenhouseCookie") jwt = cookie[1];
      }
      if (jwt == null)
        return res.status(403).json({ error: "Non authentifié" });
    } else {
      return res.status(403).json({ error: "Non authentifié" });
    }
    try {
      let tokenInfo = jsonwebtoken.verify(jwt, process.env.SECRET_JWT);
      if(tokenInfo.id==0 || !tokenInfo.id) return res.status(403).json({ error: "Accès non autorisé" });
      req.user = tokenInfo
      req.user.jwt = jwt
      next()
    } catch (error) {
      return res.status(403).json({ error: "JWT non conforme ou expiré" });
    }
    return res.status(403).json({ error: "JWT non renseigné" });
  } catch (error) {
    console.log(error);
    return res.status(503).json({ error: "Erreur" });
  }
};

module.exports = isLogged;
