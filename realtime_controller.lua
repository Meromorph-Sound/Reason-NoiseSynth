format_version = "1.0"

rtc_bindings = { 
  { source = "/environment/system_sample_rate", dest = "/global_rtc/init_instance" },
  { source = "/environment/instance_id", dest = "/global_rtc/init_instance" },
}

global_rtc = { 

  init_instance = function(source_property_path, instance_id)
    local new_no = jbox.make_native_object_rw("Instance", {instance_id})
    jbox.store_property("/custom_properties/instance", new_no);
  end,
}

sample_rate_setup = { 
native = {
    22050,
    44100,
    48000,
    88200,
    96000,
    192000
  },
}

rt_input_setup = { 
  notify = {
  "/transport/request_reset_audio",
  "/environment/master_tune",
  "/environment/system_sample_rate",
  "/note_states/*",
  "/custom_properties/alpha",
  "/custom_properties/reload",
  "/custom_properties/exponent",
  "/custom_properties/mutate",
  "/custom_properties/mutateRange",
  "/custom_properties/seed",
  "/custom_properties/pitchBendRange",
  "/custom_properties/pitchBend",
  "/custom_properties/expression"
  }
}

