package com.example.springboot;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.ThreadContext;
import datadog.trace.api.CorrelationIdentifier;

// Making a class based on RestController
@RestController
public class HelloController {

	private static final Logger logger = LogManager.getLogger(HelloController.class);

	// Respond "Hello world!" on /
	@GetMapping(value="/")
	public String index() {
		// There must be spans started and active before this block.
		try {
			ThreadContext.put("dd.trace_id", CorrelationIdentifier.getTraceId());
			ThreadContext.put("dd.span_id", CorrelationIdentifier.getSpanId());

			// Log when the root endpoint is accessed
			logger.info("Root endpoint '/' was accessed, returning Hello World response");

		} finally {
			ThreadContext.remove("dd.trace_id");
			ThreadContext.remove("dd.span_id");
		}
		
		return "Hello World!";
	}
}