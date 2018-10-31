oDataspectsCoreOntology = Dataspects::GitRepository.new(
  @oProfiles,
  "/usr/src/dataspectsSystemCoreOntology",
  @hOptions
)

oDataspectsSystemCookbook = Dataspects::GitRepository.new(
  @oProfiles,
  "/usr/src/dataspectsSystemCookbookOntology",
  @hOptions
)

oSMW = Dataspects::Semanticmediawiki.new(
  @oProfiles,
  "dataspectsSystemCookbookWiki",
  @hOptions
)

oDataspectsCoreOntology.aObjects.each do |oObject|
  oSMW.store_object(oObject, "dataspectsSystemCoreOntology injection job Lex 23.10.2018")
end

oDataspectsSystemCookbook.aObjects.each do |oObject|
  oSMW.store_object(oObject, "dataspectsSystemCookbook injection job Lex 23.10.2018")
end
