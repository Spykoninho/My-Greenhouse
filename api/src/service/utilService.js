const { createHash } = require('crypto');

class UtilService{
    constructor(){}

    checkPwd(pwd) {
        const regexSpecialChar = /[^a-zA-Z0-9]/
        const regexNumber = /[0-9]/
        const regexMajChars = /[A-Z]/
        const regexMinChars = /[a-z]/
        if(regexMajChars.test(pwd) && regexNumber.test(pwd) && regexSpecialChar.test(pwd) && regexMinChars.test(pwd)) return true
        else return false
    }

    checkEmail(email) {
        if(!isNaN(email) || email.indexOf('@')==-1 || email.indexOf('.')==-1 || email.length>255) return false
        return true
    }

    checkNewsletter(newsletter) {
        if(isNaN(newsletter) || (newsletter!=0 && newsletter!=1)) return false
        return true
    }

    createSalt(){
        let salt = Math.floor(Math.random()*10000).toString()
        return salt
    }

    hashPwd(pwd, salt){
        let saltPwd = salt+pwd+salt
        let hashedPwd = createHash('sha256').update(saltPwd).digest('base64');
        return hashedPwd
    }

    checkPostalCode(postalCode){
        try {
            if(postalCode.length<5) return false;
            return true
        } catch (error) {
            console.log("error at @checkPostalCode : " + error)
            return false
        }
    }
    
    async getInseeByPostal(postalCode){
        try {
            let resAPI = await fetch('https://public.opendatasoft.com/api/records/1.0/search/?flg=fr-fr&q=' + postalCode + '&rows=0&facet=insee_com&facet=nom_dept&facet=nom_region&facet=statut&dataset=correspondance-code-insee-code-postal&timezone=Europe%2FBerlin&lang=fr')
            let resJson = await resAPI.json()
            return resJson.facet_groups[0].facets[0].name
        } catch (error) {
            console.log("error at @getInseeByPostal : " + error)
            return false
        }
    }
}

module.exports = UtilService