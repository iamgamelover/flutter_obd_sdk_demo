var obdApi = new ObdApi();

/**
 * Type -102004 Protocol is used to sign up a new user 
 * by hirarchecal deterministic wallet system integrated in OBD.
 */
function genMnemonic() {
    let mnemonic = btctool.generateMnemonic(128);
    console.info('SDK - genMnemonic = ' + mnemonic);
    sdkSaveMnemonic(mnemonic);
    return mnemonic;
}

/**
 * Type -102001 Protocol is used to login to OBD.
 * @param mnemonic 
 * @param callback 
 */
function logIn(mnemonic, callback) {
    obdApi.logIn(mnemonic, callback);
}

// FOR TEST
// mnemonic words generated with signUp api save to local storage.
function sdkSaveMnemonic(value) {

    // let mnemonic = JSON.parse(sessionStorage.getItem(itemMnemonic));
    let mnemonic = JSON.parse(localStorage.getItem('saveMnemonic'));

    // If has data.
    if (mnemonic) {
        console.info('sdkSaveMnemonic -  HAS DATA');
        let new_data = {
            mnemonic: value,
        }
        mnemonic.result.push(new_data);
        // sessionStorage.setItem(itemMnemonic, JSON.stringify(mnemonic));
        localStorage.setItem('saveMnemonic', JSON.stringify(mnemonic));

    } else {
        console.info('sdkSaveMnemonic - FIRST DATA');
        let data = {
            result: [{
                mnemonic: value
            }]
        }
        // sessionStorage.setItem(itemMnemonic, JSON.stringify(data));
        localStorage.setItem('saveMnemonic', JSON.stringify(data));
    }
}

// FOR TEST
// Get mnemonic words from local storage.
function sdkGetMnemonic() {

    let resp = JSON.parse(localStorage.getItem('saveMnemonic'));

    // If has data.
    if (resp) {
        console.info('sdkGetMnemonic - HAS DATA');
        let lastest = resp.result.length - 1;
        console.info('sdkGetMnemonic - lastest = ' + lastest);
        console.info('sdkGetMnemonic - DATA = ' + resp.result[lastest].mnemonic);
        return resp.result[lastest].mnemonic;

        // for (let i = 0; i < resp.result.length; i++) {
        //     if ($("#logined").text() === resp.result[i].userID) {
        //         for (let j = 0; j < resp.result[i].data.length; j++) {
        //             if (pubkey === resp.result[i].data[j].pubkey) {
        //                 return resp.result[i].data[j].wif;
        //             }
        //         }
        //     }
        // }
        // return '';
    } else {
        return 'NO DATA';
    }
}