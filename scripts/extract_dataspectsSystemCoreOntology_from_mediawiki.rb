oOntologyRepo = Dataspects::OntologyRepository.new(
  @oProfiles,
  "/usr/src/workspace/OntologyRepo",
  @hOptions
)

#
oSMW = Dataspects::SemanticMediaWiki.new(
  @oProfiles,
  "dataspectsStandardSystemSemanticMediaWiki",
  @hOptions
)

oPages = Dataspects::Facet.new
oPages.from_oSEMANTICMEDIAWIKI(oSMW)
# oPages.from_sRECENTCHANGES("24h")
# oPages.from_mASK_QUERIES("[[Checkliste_Dienstplanung_Assistenzärzte_(AN)]]") do |sSMWPageName|
oPages.from_mCATEGORIES("Entity") do |sSMWPageName|
  oOntologyRepo.store_object(
    Dataspects::SemanticmediawikiPage.new(oSMW, {
        sSMWPageName: sSMWPageName
      }.to_json
    )
  )
end
