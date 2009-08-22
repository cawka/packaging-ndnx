package com.parc.ccn.data.query;

import javax.xml.stream.XMLStreamException;

import com.parc.ccn.data.util.DataUtils;
import com.parc.ccn.data.util.XMLDecoder;
import com.parc.ccn.data.util.XMLEncoder;

/**
 * This represents a Component with an ExcludeFilter
 */
public class ExcludeComponent extends ExcludeFilter.Element implements Comparable<ExcludeComponent> {
	public static final String COMPONENT = "Component";
	protected byte [] body = null;
	
	public ExcludeComponent(byte [] component) {
		body = component.clone();
	}

	public ExcludeComponent() {
	}
	
	@Override
	public void decode(XMLDecoder decoder) throws XMLStreamException {
		body = decoder.readBinaryElement(COMPONENT);
	}

	@Override
	public void encode(XMLEncoder encoder) throws XMLStreamException {
		encoder.writeElement(COMPONENT, body);
	}
	
	public int compareTo(ExcludeComponent component) {
		return DataUtils.compare(body, component.body);
	}

	public int compareTo(byte [] component) {
		return DataUtils.compare(body, component);
	}

	@Override
	public boolean validate() {
		return body != null;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (!(obj instanceof ExcludeComponent))
			return false;
		ExcludeComponent ec = (ExcludeComponent) obj;
		return DataUtils.arrayEquals(body, ec.body);
	}

	public byte [] getBytes() {
		return body.clone();
	}
}
