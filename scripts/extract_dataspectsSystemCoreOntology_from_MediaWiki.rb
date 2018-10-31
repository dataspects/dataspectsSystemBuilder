oOntologyRepo = Dataspects::OntologyRepository.new(
  @oProfiles,
  "/usr/src/workspace/OntologyRepo",
  @hOptions
)

#
oSMW = Dataspects::Semanticmediawiki.new(
  @oProfiles,
  "dataspectsSystemCookbookWiki",
  @hOptions
)

oPages = Dataspects::Facet.new
oPages.from_oSEMANTICmediawiki(oSMW)
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
