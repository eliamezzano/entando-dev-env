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

ENTANDO_TENANTS=[
    {
        "tenantCode": "t1",
        "fqdns": "t1.entando.local",
        "kcEnabled": true,
        "kcAuthUrl": "http://t1.entando.local/auth",
        "kcRealm": "entando-t1",
        "kcClientId": "external",
        "kcClientSecret": "external",
        "kcPublicClientId": "webapp",
        "kcSecureUris": "",
        "kcDefaultAuthorizations": "",
        "dbDriverClassName": "org.postgresql.Driver",
        "dbUrl": "jdbc:postgresql://172.17.0.1:15432/entando?currentSchema=t1",
        "dbUsername": "t1",
        "dbPassword": "t1",
        "cdsEnabled": true,
        "cdsPublicUrl": "http://t1.entando.local/cds",
        "cdsPrivateUrl": "http://172.17.0.1:18081/",
        "cdsPath": "api/v1", 
        "dbMigrationStrategy": "AUTO"
    }, 
    {
        "tenantCode": "t2",
        "fqdns": "t2.entando.local",
        "kcEnabled": true,
        "kcAuthUrl": "http://t2.entando.local/auth",
        "kcRealm": "entando-t2",
        "kcClientId": "external",
        "kcClientSecret": "external",
        "kcPublicClientId": "webapp",
        "kcSecureUris": "",
        "kcDefaultAuthorizations": "",
        "dbDriverClassName": "org.postgresql.Driver",
        "dbUrl": "jdbc:postgresql://172.17.0.1:15432/entando?currentSchema=t2",
        "dbUsername": "t2",
        "dbPassword": "t2",
        "cdsEnabled": true,
        "cdsPublicUrl": "http://t2.entando.local/cds",
        "cdsPrivateUrl": "http://172.17.0.1:18082/",
        "cdsPath": "api/v1", 
        "dbMigrationStrategy": "AUTO"
    }, 
    {
        "tenantCode": "t3",
        "fqdns": "t3.entando.local",
        "kcEnabled": true,
        "kcAuthUrl": "http://t3.entando.local/auth",
        "kcRealm": "entando-t3",
        "kcClientId": "external",
        "kcClientSecret": "external",
        "kcPublicClientId": "webapp",
        "kcSecureUris": "",
        "kcDefaultAuthorizations": "",
        "dbDriverClassName": "org.postgresql.Driver",
        "dbUrl": "jdbc:postgresql://172.17.0.1:15432/entando?currentSchema=t3",
        "dbUsername": "t3",
        "dbPassword": "t3",
        "cdsEnabled": true,
        "cdsPublicUrl": "http://t3.entando.local/cds",
        "cdsPrivateUrl": "http://172.17.0.1:18083/",
        "cdsPath": "api/v1", 
        "dbMigrationStrategy": "AUTO"
    }
];
```