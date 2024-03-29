const auth = async () => {
  
  
  // 1) get config
  const  { tenantDomain, qlikWebIntegrationId, appId, currentLoginType} =  {
    currentLoginType: 'jwt-login',
    // app config 
    qlikWebIntegrationId: "F7FFR6c76j--BIS-D_ANmsEPU1-VIiXF",
    tenantDomain: "bpvjpykbczgl7xl.us.qlikcloud.com",
    appId: "196803b0-33c2-4492-ac3b-77f6318bce47",

  };
  const config = { tenantDomain, qlikWebIntegrationId, appId, currentLoginType };
  await handleAutomaticLogin()
  
  
  async function handleAutomaticLogin() {
    const token = await (await fetch("https://utuwtwnthj.execute-api.us-east-1.amazonaws.com/Cores-test/qlik-test-api", {
      method: "GET",
      mode: "cors"
    }).then(resp => resp.json().then(data => data.body))); 

    // 2.1) login, in order to save some credentials in browser storage
    //    we are going to need these for next api calls like getting CSRF token
    const login = await (await fetch(
      `https://${tenantDomain}/login/jwt-session?qlik-web-integration-id=${qlikWebIntegrationId}`,
      {
        method: "POST",
        credentials: "include",
        mode: "cors",
        headers: {
          "content-type": "application/json",
          Authorization: `Bearer ${token}`,
          "qlik-web-integration-id": qlikWebIntegrationId
        },
        rejectunAuthorized: false
      }
    ));
  }
  
  // 3) get CSRF token
  const csrfTokenInfo = await await fetch(
    `https://${tenantDomain}/api/v1/csrf-token?qlik-web-integration-id=${qlikWebIntegrationId}`,
    {
      credentials: "include",
      headers: {
        "Qlik-Web-Integration-ID": qlikWebIntegrationId
      }
    }
  );
    
  // 8) if we reached in this step with out any error, try to remove the helper box
  // shouldLoginBox.style.display = 'none'
 
  return { config, csrfTokenInfo }
}

const auth2 = async () => {
  
  
  // 1) get config
  const  { tenantDomain, qlikWebIntegrationId, appId, currentLoginType} =  {
    currentLoginType: 'jwt-login',
    // app config 
    qlikWebIntegrationId: "F7FFR6c76j--BIS-D_ANmsEPU1-VIiXF",
    tenantDomain: "bpvjpykbczgl7xl.us.qlikcloud.com",
    appId: "196803b0-33c2-4492-ac3b-77f6318bce47",

  };
  const config = { tenantDomain, qlikWebIntegrationId, appId, currentLoginType };
  await handleAutomaticLogin()
  
  
  async function handleAutomaticLogin() {
    const token = await (await fetch("https://utuwtwnthj.execute-api.us-east-1.amazonaws.com/Cores-test/qlik-test-api", {
      method: "GET",
      mode: "cors"
    }).then(resp => resp.json().then(data => data.body))); 

    // 2.1) login, in order to save some credentials in browser storage
    //    we are going to need these for next api calls like getting CSRF token
    const login = await (await fetch(
      `https://${tenantDomain}/login/jwt-session?qlik-web-integration-id=${qlikWebIntegrationId}`,
      {
        method: "POST",
        credentials: "include",
        mode: "cors",
        headers: {
          "content-type": "application/json",
          Authorization: `Bearer ${token}`,
          "qlik-web-integration-id": qlikWebIntegrationId
        },
        rejectunAuthorized: false
      }
    ));
  }
  
  // 3) get CSRF token
  const csrfTokenInfo = await await fetch(
    `https://${tenantDomain}/api/v1/csrf-token?qlik-web-integration-id=${qlikWebIntegrationId}`,
    {
      credentials: "include",
      headers: {
        "Qlik-Web-Integration-ID": qlikWebIntegrationId
      }
    }
  );
    
  // 8) if we reached in this step with out any error, try to remove the helper box
  // shouldLoginBox.style.display = 'none'
 
  return { config, csrfTokenInfo }
}

