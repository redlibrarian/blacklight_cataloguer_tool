require "open-uri"
require "nokogiri"

class SirsiRecord
  def initialize(record)
   @record_hash = {}
   marc_fields = record.xpath("//MarcEntryInfo")
   marc_fields.each do |field|
     if field.xpath(".//label").text == "Title"
       @record_hash[:title] = field.xpath(".//text").text
     end
   end
  end

  def record
    @record_hash
  end
end

class SirsiService

  def initialize(catkey)
  @sirsi_endpoint = "https://ws.library.ualberta.ca/symws3/rest/standard/lookupTitleInfo?clientID=Primo&marcEntryFilter=ALL&includeItemInfo=true&includeAvailabilityInfo=true&includeMarcHoldings&titleID="
  @record = Nokogiri::XML(open(@sirsi_endpoint+catkey)).remove_namespaces!
  end

  def record
    SirsiRecord.new(@record).record
  end
end
