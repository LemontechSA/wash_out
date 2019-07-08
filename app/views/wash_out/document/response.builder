xml.instruct! :xml, :version=>"1.0"
xml.tag! "SOAP-ENV:Envelope",
         "xmlns:SOAP-ENV" => 'http://schemas.xmlsoap.org/soap/envelope/',
         "xmlns:xsd" => 'http://www.w3.org/2001/XMLSchema',
         "xmlns:xsi" => 'http://www.w3.org/2001/XMLSchema-instance',
         "xmlns:SOAP-ENC" => "http://schemas.xmlsoap.org/soap/encoding/",
         "xmlns:tns" => @namespace do
  if !header.nil?
    xml.tag! "soap:Header" do
      xml.tag! "tns:#{@action_spec[:response_tag]}" do
        wsdl_data xml, header
      end
    end
  end
  xml.tag! "SOAP-ENV:Body" do
    xml.tag! "ns1:#{@action_spec[:response_tag]}", { "xmlns:ns1" => "urn:TimeTracking"} do
      first_result = result.first
      if first_result && first_result.type == 'xml'
        xml.<<(result.first.value)
      else
        wsdl_data xml, result
      end
    end
  end
end
