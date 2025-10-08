```
PORTDB_DRIVER=postgresql;
SERVDB_DRIVER=postgresql;

CDS_ENABLED=true;
CDS_PATH=/api/v1;
CDS_PRIVATE_URL=http://172.17.0.1:18080/;
CDS_PUBLIC_URL=http://portal.entando.local/cds;
CDS_PUBLIC_PATH=/public;

KEYCLOAK_ENABLED=true;
KEYCLOAK_AUTH_URL=http://portal.entando.local/auth;
KEYCLOAK_REALM=entando-dev;
KEYCLOAK_CLIENT_ID=external;
KEYCLOAK_CLIENT_SECRET=external;
KEYCLOAK_PUBLIC_CLIENT_ID=webapp;

REDIS_ACTIVE=true;
REDIS_SESSION_ACTIVE=false;
REDIS_ADDRESS=redis://172.17.0.1:16379;

LOG_LEVEL=INFO;
ROOT_LOG_LEVEL=INFO;

APPBUILDERINTEGRATIONENABLED=true;
SERVER_SERVLET_CONTEXT_PATH=/;
ENTANDO_ENGINE_WEB_CONTEXT=/;
ENTANDO_WEB_CONTEXT=/;
ENTANDO_VIRTUAL_CONTEXTS=t1,t2,t3,;

ENTANDO_TENANTS=[
    {
        "tenantCode": "t1",
        "context": "t1",
        "entandoAppIngressName": "t1-portal-entando-local",
        "fqdns": "portal.entando.local",
        "kcEnabled": true,
        "kcAuthUrl": "http://portal.entando.local/auth",
        "kcInternalAuthUrl": "http://portal.entando.local/auth",
        "kcRealm": "entando-t1",
        "kcClientId": "external",
        "kcClientSecret": "external",
        "kcPublicClientId": "webapp",
        "kcAdminUsername": "admin",
        "kcAdminPassword": "adminadmin",
        "kcSecureUris": "",
        "kcDefaultAuthorizations": "",
        "dbDriverClassName": "org.postgresql.Driver",
        "dbUrl": "jdbc:postgresql://172.17.0.1:15432/entando?currentSchema=t1",
        "dbUsername": "t1",
        "dbPassword": "t1",
        "cdsEnabled": true,
        "cdsPublicUrl": "http://portal.entando.local/cds-t1",
        "cdsPublicPath": "/public",
        "cdsInternalPublicSection": "/public",
        "cdsPrivateUrl": "http://172.17.0.1:18081/",
        "cdsPath": "api/v1", 
        "dbMigrationStrategy": "AUTO"
    }, 
    {
        "tenantCode": "t2",
        "context": "t2",
        "entandoAppIngressName": "t2-portal-entando-local",
        "fqdns": "portal.entando.local",
        "kcEnabled": true,
        "kcAuthUrl": "http://portal.entando.local/auth",
        "kcInternalAuthUrl": "http://portal.entando.local/auth",
        "kcRealm": "entando-t2",
        "kcClientId": "external",
        "kcClientSecret": "external",
        "kcPublicClientId": "webapp",
        "kcAdminUsername": "admin",
        "kcAdminPassword": "adminadmin",
        "kcSecureUris": "",
        "kcDefaultAuthorizations": "",
        "dbDriverClassName": "org.postgresql.Driver",
        "dbUrl": "jdbc:postgresql://172.17.0.1:15432/entando?currentSchema=t2",
        "dbUsername": "t2",
        "dbPassword": "t2",
        "cdsEnabled": true,
        "cdsPublicUrl": "http://portal.entando.local/cds-t2",
        "cdsPublicPath": "/public",
        "cdsInternalPublicSection": "/public",
        "cdsPrivateUrl": "http://172.17.0.1:18082/",
        "cdsPath": "api/v1", 
        "dbMigrationStrategy": "AUTO"
    }, 
    {
        "tenantCode": "t3",
        "context": "t3",
        "entandoAppIngressName": "t3-portal-entando-local",
        "fqdns": "portal.entando.local",
        "kcEnabled": true,
        "kcAuthUrl": "http://portal.entando.local/auth",
        "kcInternalAuthUrl": "http://portal.entando.local/auth",
        "kcRealm": "entando-t3",
        "kcClientId": "external",
        "kcClientSecret": "external",
        "kcPublicClientId": "webapp",
        "kcAdminUsername": "admin",
        "kcAdminPassword": "adminadmin",
        "kcSecureUris": "",
        "kcDefaultAuthorizations": "",
        "dbDriverClassName": "org.postgresql.Driver",
        "dbUrl": "jdbc:postgresql://172.17.0.1:15432/entando?currentSchema=t3",
        "dbUsername": "t3",
        "dbPassword": "t3",
        "cdsEnabled": true,
        "cdsPublicUrl": "http://portal.entando.local/cds-t3",
        "cdsPublicPath": "/public",
        "cdsInternalPublicSection": "/public",
        "cdsPrivateUrl": "http://172.17.0.1:18083/",
        "cdsPath": "api/v1", 
        "dbMigrationStrategy": "AUTO"
    }
];
```