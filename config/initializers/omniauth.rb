namespace1 = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims"
namespace2 = "http://schemas.microsoft.com/identity/claims"
attributes_map = {
  uid: ["#{namespace2}/objectidentifier"],
  name: ["#{namespace2}/displayname"],
  email: ["#{namespace1}/emailaddress"]
}
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
           issuer: "app-push-dev",
           assertion_consumer_service_url: "https://localhost:3000/users/auth/saml/callback",
          #  idp_sso_target_url: Rails.application.credentials.dig(:sso, :idp_sso_target_url),
           idp_sso_target_url: "https://login.microsoftonline.com/07a9d415-170d-4e6b-879b-baace20c014f/saml2",
           idp_slo_target_url: "https://login.microsoftonline.com/common/wsfederation?wa=wsignout1.0",
           attribute_statements: attributes_map,
           idp_cert: Rails.root.join("config", "pushtech-dev.cer").read,
          #  idp_cert_fingerprint: Rails.application.credentials.dig(:sso, :idp_cert_fingerprint),
          #  idp_cert_fingerprint: "26:18:59:18:E3:4D:EC:EA:67:55:28:4A:F6:3C:DC:7B:EF:A5:7E:E1:AA:A6:8F:8C:9C:D8:3C:21:FD:4B:94:95",
           idp_cert_fingerprint: "E2:C7:DC:70:BE:3F:FD:6D:87:70:B0:E3:3B:FC:56:B5:68:73:28:65",
           name_identifier_format: "urn:oasis:names:tc:SAML:2.0:nameid-format:transient",
           uid_attribute: attributes_map[:uid].first
end