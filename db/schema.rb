# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_24_053744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "dblink"
  enable_extension "edb_dblink_libpq"
  enable_extension "edb_dblink_oci"
  enable_extension "edbspl"
  enable_extension "pldbgapi"
  enable_extension "plpgsql"
  enable_extension "plpython2u"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "street"
    t.string "city"
    t.string "region"
    t.string "country"
    t.string "postal_code"
    t.string "company"
    t.string "source"
    t.string "job_title"
    t.string "dob"
    t.string "full_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "iso_settings", force: :cascade do |t|
    t.string "plant"
    t.string "sfg_code"
    t.string "iso_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sfg_code", "plant"], name: "index_iso_settings_on_sfg_code_and_plant"
  end

  create_table "mat_group_masters", force: :cascade do |t|
    t.string "name"
    t.string "prepared_by"
    t.string "reviewed_by"
    t.string "approved_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "current", default: false
  end

  create_table "material_masters", id: :serial, force: :cascade do |t|
    t.string "material_code", limit: 40, null: false
    t.string "material_description", limit: 40
    t.string "material_type", limit: 10
    t.string "material_group", limit: 30
    t.string "uom", limit: 3
    t.integer "self_life", default: 0
    t.string "plant", limit: 4
    t.string "str_loc", limit: 4
    t.string "prod_str_loc", limit: 4
    t.string "cycle_time", limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 30
    t.string "updated_by", limit: 30
    t.string "alter_uom", limit: 3
    t.string "numerator", limit: 5
    t.string "denominator", limit: 5
    t.string "material_group_name", limit: 50
  end

  create_table "mcn_line_masters", force: :cascade do |t|
    t.string "plant", null: false
    t.string "machine_line"
    t.string "machine_code"
    t.string "machine_name"
    t.string "work_center"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mcn_master", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.string "werks", limit: 20
    t.string "arbpl", limit: 20
    t.string "mcn_code", limit: 20
    t.string "survey_area", limit: 40
    t.string "upd_datetime", limit: 20, default: -> { "to_char(now(), 'YYYY-MM-DD HH24:MI:SS'::text)" }
    t.decimal "log_ts", default: -> { "trunc((date_part('epoch'::text, now()))::numeric, 0)" }
  end

  create_table "mixer_versions", force: :cascade do |t|
  end

  create_table "mst_bom_dtls", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.string "plant", limit: 4
    t.string "sfg_code", limit: 40
    t.string "sfg_desc", limit: 40
    t.string "bom_no", limit: 8
    t.string "alt_bom_no", limit: 2
    t.decimal "base_qty", precision: 12, scale: 3, default: "0.0"
    t.string "sfg_uom", limit: 3
    t.decimal "base_altqty_kg", precision: 12, scale: 3, default: "0.0"
    t.string "comp_group", limit: 10
    t.string "comp_code", limit: 40
    t.string "comp_desc", limit: 40
    t.decimal "comp_qty", precision: 12, scale: 3, default: "0.0"
    t.string "comp_uom", limit: 3
    t.decimal "comp_altqty_kg", precision: 12, scale: 3, default: "0.0"
    t.string "iss_lgort", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "comp_no", limit: 4
    t.string "work_center"
  end

  create_table "mst_bom_hdrs", id: :serial, force: :cascade do |t|
    t.string "plant", limit: 4
    t.string "work_center", limit: 10
    t.string "sfg_code", limit: 40
    t.string "sfg_desc", limit: 50
    t.string "bom_type", limit: 1
    t.decimal "base_qty", precision: 12, scale: 3
    t.string "sfg_uom", limit: 3
    t.decimal "alt_base_qty", precision: 12, scale: 3
    t.string "alt_sfg_uom_kg", limit: 3
    t.datetime "valid_from"
    t.string "alt_bom_no", limit: 2
    t.string "bom_no", limit: 8
    t.string "alt_bom_text", limit: 40
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mst_list_values", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.string "group_name", limit: 20, null: false
    t.string "list_value", limit: 30, null: false
    t.string "status", limit: 1, default: "Y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mst_matgroups", force: :cascade do |t|
    t.string "mat_group"
    t.string "mat_group_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mst_mics", force: :cascade do |t|
    t.string "mat_group"
    t.string "mat_group_desc"
    t.string "mat_code"
    t.string "mat_desc"
    t.string "task_lst_group"
    t.string "mic"
    t.string "inspection_method"
    t.string "uom"
    t.string "sampling_procedure"
    t.float "decimal_points"
    t.string "char_type"
    t.float "lower_spec_limit"
    t.float "upper_spec_limit"
    t.float "target_value"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mst_plant", id: :serial, force: :cascade do |t|
    t.string "plant", limit: 4, null: false
    t.string "plant_name", limit: 30, null: false
    t.string "status", limit: 1, default: "A"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "plant_type"
  end

  create_table "mst_vendor_temp", id: :serial, force: :cascade do |t|
    t.string "ven_group", limit: 4, null: false
    t.string "ven_code", limit: 10, null: false
    t.string "name1", limit: 100, null: false
    t.string "name2", limit: 100, null: false
    t.string "gst_no", limit: 18, null: false
    t.string "status", limit: 2, default: "N"
    t.string "reason", limit: 60
  end

  create_table "mst_work_centers", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('mst_work_center_id_seq'::regclass)" }, null: false
    t.string "plant", limit: 4, null: false
    t.string "loc", limit: 4
    t.string "wc_code", limit: 10, null: false
    t.string "wc_desc", limit: 60
    t.string "status", limit: 1, default: "Y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name"
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
  end

  create_table "sign_group_masters", force: :cascade do |t|
    t.string "mat_group", null: false
    t.string "sign_type", null: false
    t.string "name"
    t.string "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "selected", default: false
    t.index ["mat_group", "sign_type", "name"], name: "index_sign_group_masters_on_mat_group_and_sign_type_and_name"
  end

  create_table "spec_bom_ack_json", id: false, force: :cascade do |t|
    t.text "data"
  end

  create_table "spec_bom_ack_temp", id: false, force: :cascade do |t|
    t.text "mobunqno"
    t.text "mobdocno"
    t.text "sapstatus"
    t.text "message"
    t.text "stlal"
    t.text "changeno"
    t.datetime "created_at"
  end

  create_table "spec_bom_ack_temp_json", id: false, force: :cascade do |t|
    t.text "data"
  end

  create_table "spec_footers", force: :cascade do |t|
    t.string "doc_no", null: false
    t.datetime "doc_date"
    t.string "material_version"
    t.text "spec_footer1"
    t.text "spec_footer2"
    t.text "spec_footer3"
    t.text "quality_footer1"
    t.text "quality_footer2"
    t.text "quality_footer3"
    t.text "review_comments"
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reason_for_activate"
  end

  create_table "spec_headers", force: :cascade do |t|
    t.string "doc_no"
    t.datetime "doc_date"
    t.string "doc_type"
    t.string "spec_type"
    t.string "project_name"
    t.string "vendor_code"
    t.string "vendor_name"
    t.string "plant"
    t.string "reason_for_change"
    t.string "machine_line"
    t.string "machine_code"
    t.string "material_version"
    t.string "sfg_code"
    t.string "sfg_desc"
    t.string "sfg_stage"
    t.string "spec_status"
    t.datetime "g_date"
    t.datetime "i_date"
    t.datetime "p_date"
    t.datetime "o_date"
    t.datetime "completed_date"
    t.datetime "reviewed_date"
    t.datetime "approved_date"
    t.datetime "print_date"
    t.string "sap_status", default: "N"
    t.datetime "sap_uploaded_date"
    t.string "bom_no"
    t.decimal "output_qty"
    t.string "sfg_uom"
    t.string "issue_no"
    t.datetime "issue_date"
    t.datetime "effective_date"
    t.string "superceded_issue_no"
    t.datetime "superceded_issue_dt"
    t.string "reference_no"
    t.string "preparead_by"
    t.string "reviewed_by"
    t.string "approved_by"
    t.string "remarks"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
    t.boolean "active", default: true
    t.string "display_spec_code"
    t.string "compound_version"
    t.boolean "activate_bom", default: false
    t.string "lot_uom"
    t.string "machine_name"
    t.boolean "disable_edit", default: false
    t.decimal "lot_size", precision: 10, scale: 3
    t.integer "mobunqno"
    t.string "bom_change", default: "N"
    t.datetime "sap_transfer_dt"
    t.string "bom_mode"
    t.integer "mobchangeno"
    t.integer "process_type", default: 0
  end

  create_table "spec_input_dtls", force: :cascade do |t|
    t.string "doc_no"
    t.datetime "doc_date"
    t.string "spec_type"
    t.string "mat_spec_type"
    t.string "sfg_code"
    t.string "lot_uom"
    t.decimal "lot_size", precision: 10, scale: 3
    t.string "machine_code"
    t.string "machine_description"
    t.string "bom_no"
    t.string "sap_bom_no"
    t.string "material_version"
    t.integer "issue_no"
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "machine_line"
    t.boolean "is_saved", default: false
  end

  create_table "spec_input_materials", force: :cascade do |t|
    t.bigint "spec_input_dtl_id", null: false
    t.string "material_code"
    t.string "material_description"
    t.string "material_uom"
    t.decimal "material_qty", precision: 10, scale: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_no"
    t.string "doc_no"
    t.string "material_version"
    t.string "sfg_code"
    t.string "sap_sl_no"
    t.integer "mobunqno"
    t.string "sap_status", default: "N"
    t.string "is_deleted", default: "N"
    t.string "is_changed", default: "N"
    t.string "is_added", default: "N"
    t.integer "mobchangeno"
    t.string "bom_mode"
    t.index ["is_deleted", "is_changed"], name: "index_spec_input_materials_on_is_deleted_and_is_changed"
    t.index ["spec_input_dtl_id"], name: "index_spec_input_materials_on_spec_input_dtl_id"
  end

  create_table "spec_process_dtls", force: :cascade do |t|
    t.string "doc_no"
    t.datetime "doc_date"
    t.string "machine_line"
    t.string "material_version"
    t.string "sfg_code"
    t.string "process_type"
    t.string "process_num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_saved", default: false
  end

  create_table "spec_process_inputs", force: :cascade do |t|
    t.bigint "spec_process_dtl_id", null: false
    t.bigint "spec_process_master_input_id"
    t.string "from_value"
    t.string "to_value"
    t.string "addl_info"
    t.string "spec_info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "from_tolerance"
    t.string "to_tolerance"
    t.boolean "show_add_info", default: true
    t.string "process_workcenter"
    t.string "process_sequence"
    t.string "process_uom"
    t.string "process_type"
    t.integer "sequence_order"
    t.string "master_type"
    t.index ["spec_info", "process_sequence"], name: "index_spec_process_inputs_on_spec_info_and_process_sequence"
    t.index ["spec_process_dtl_id"], name: "index_spec_process_inputs_on_spec_process_dtl_id"
    t.index ["spec_process_master_input_id"], name: "index_spec_process_inputs_on_spec_process_master_input_id"
  end

  create_table "spec_process_master_inputs", force: :cascade do |t|
    t.bigint "spec_process_master_id", null: false
    t.string "process_workcenter"
    t.string "process_sequence"
    t.string "process_uom"
    t.string "process_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "master_type"
    t.integer "sequence_order"
    t.string "tolerance", default: "No"
    t.index ["spec_process_master_id"], name: "index_spec_process_master_inputs_on_spec_process_master_id"
  end

  create_table "spec_process_masters", force: :cascade do |t|
    t.string "name"
    t.datetime "process_date"
    t.boolean "status", default: true
    t.boolean "submitted_flag", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "plant"
    t.string "machine_line"
  end

  create_table "spec_setup_dtls", force: :cascade do |t|
    t.string "doc_no", limit: 20
    t.datetime "doc_date"
    t.string "spec_type"
    t.string "setup_machineline"
    t.string "material_version"
    t.string "sfg_code"
    t.string "setup_no"
    t.datetime "setup_date"
    t.string "setup_workcenter"
    t.string "setup_sequence"
    t.string "setup_uom"
    t.string "setup_type"
    t.string "from_value"
    t.string "to_value"
    t.string "addl_info"
    t.string "spec_info"
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_saved", default: false
  end

  create_table "spec_setup_input_dtls", force: :cascade do |t|
    t.bigint "spec_setup_master_dtl_id"
    t.bigint "spec_setup_dtl_id", null: false
    t.string "from_value"
    t.string "to_value"
    t.string "addl_info"
    t.string "spec_info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "from_tolerance"
    t.string "to_tolerance"
    t.boolean "show_add_info", default: true
    t.string "setup_workcenter"
    t.string "setup_sequence"
    t.string "setup_uom"
    t.string "setup_type"
    t.integer "sequence_order"
    t.index ["spec_info", "setup_sequence"], name: "index_spec_setup_input_dtls_on_spec_info_and_setup_sequence"
    t.index ["spec_setup_dtl_id"], name: "index_spec_setup_input_dtls_on_spec_setup_dtl_id"
    t.index ["spec_setup_master_dtl_id"], name: "index_spec_setup_input_dtls_on_spec_setup_master_dtl_id"
  end

  create_table "spec_setup_master_dtls", force: :cascade do |t|
    t.bigint "spec_setup_master_id", null: false
    t.string "setup_workcenter"
    t.string "setup_sequence"
    t.string "setup_uom"
    t.string "setup_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_order"
    t.string "tolerance", default: "No"
    t.index ["spec_setup_master_id"], name: "index_spec_setup_master_dtls_on_spec_setup_master_id"
  end

  create_table "spec_setup_masters", force: :cascade do |t|
    t.string "setup_name", limit: 40, null: false
    t.datetime "setup_date", null: false
    t.boolean "status", default: true
    t.boolean "submitted_flg", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "plant"
    t.string "machine_line"
  end

  create_table "trnsamplehdrs", force: :cascade do |t|
    t.bigint "trnsamples_id"
    t.string "test_sample_id"
    t.string "barcode_key"
    t.string "vendor_batchno"
    t.datetime "mfg_date"
    t.datetime "revised_mfgdt"
    t.string "location_id"
    t.string "sap_inspection_lot"
    t.float "sample_qty"
    t.string "tester_name"
    t.string "sample_status"
    t.datetime "status_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "grn_no", limit: 10
    t.string "mat_code", limit: 40
    t.string "sap_batch", limit: 10
    t.index ["trnsamples_id"], name: "index_trnsamplehdrs_on_trnsamples_id"
  end

  create_table "trnsampleinspdtls", force: :cascade do |t|
    t.bigint "trnsamples_id"
    t.string "test_sample_id"
    t.string "sap_inspection_lot"
    t.string "mat_code"
    t.string "mat_desc"
    t.string "inspection_result"
    t.string "grn_release"
    t.string "reason_rejection"
    t.string "waiver_no"
    t.string "flash_report_ref"
    t.float "grn_batch_qty"
    t.float "ur"
    t.float "cs"
    t.float "bl"
    t.string "save_flag"
    t.string "ud_code"
    t.float "ur_qty"
    t.float "bl_qty"
    t.string "sap_status"
    t.string "sap_err_msg"
    t.datetime "sap_trnasfer_dt"
    t.datetime "sap_transfer_ack_dt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trnsamples_id"], name: "index_trnsampleinspdtls_on_trnsamples_id"
  end

  create_table "trnsamplemicacts", force: :cascade do |t|
    t.bigint "trnsampleinspdtl_id"
    t.bigint "trnsamplehdrs_id"
    t.integer "material_id"
    t.string "sap_inspection_lot"
    t.string "mat_group"
    t.string "mat_group_desc"
    t.string "mat_code"
    t.string "mat_desc"
    t.string "mat_uom"
    t.string "mic_code"
    t.string "inspection_method"
    t.string "insp_uom"
    t.string "sampling_procedure"
    t.float "decimal_points"
    t.string "char_type"
    t.float "lower_spec_limit"
    t.float "upper_spec_limit"
    t.float "target_value"
    t.string "test_result"
    t.float "tsl_actual_value"
    t.float "tsl_supplier_value"
    t.integer "iteration_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trnsamplehdrs_id"], name: "index_trnsamplemicacts_on_trnsamplehdrs_id"
    t.index ["trnsampleinspdtl_id"], name: "index_trnsamplemicacts_on_trnsampleinspdtl_id"
  end

  create_table "trnsamples", force: :cascade do |t|
    t.string "test_type"
    t.string "plant"
    t.string "str_loc"
    t.string "grn_no"
    t.datetime "grn_date"
    t.string "vendor_code"
    t.string "vendor_name"
    t.string "mat_group"
    t.string "mat_group_name"
    t.string "mat_code"
    t.string "mat_desc"
    t.string "mat_uom"
    t.float "grn_qty"
    t.string "sample_type"
    t.integer "no_of_samples"
    t.integer "priority"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trnsampletrns", force: :cascade do |t|
    t.bigint "trnsamplehdrs_id"
    t.string "test_sample_id"
    t.string "tester_name"
    t.string "sample_status"
    t.datetime "status_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trnsamplehdrs_id"], name: "index_trnsampletrns_on_trnsamplehdrs_id"
  end

  create_table "trt_masters", force: :cascade do |t|
    t.string "sfg_code"
    t.string "material_version"
    t.string "trt_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "plant"
    t.boolean "active", default: true
    t.index ["sfg_code", "trt_code"], name: "index_trt_masters_on_sfg_code_and_trt_code"
  end

  create_table "trt_msts", force: :cascade do |t|
    t.string "sfg_code", limit: 100
    t.string "sfg_desc", limit: 50
    t.string "fabric_code", limit: 100
    t.string "fabric_desc", limit: 50
    t.string "comp_code", limit: 100
    t.string "comp_desc", limit: 50
    t.string "vendor_code", limit: 50
    t.string "vendor_name", limit: 50
    t.string "trt_identification", limit: 40
    t.string "trt_code", limit: 16
    t.decimal "gauge", precision: 12, scale: 3
    t.string "trt_status", limit: 1
    t.datetime "valid_from"
    t.bigint "user_id"
    t.string "device_id", limit: 50
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "trt_width", precision: 7, scale: 2
    t.decimal "width", precision: 3, scale: 2
    t.string "material_version"
    t.text "alternative_trt"
    t.decimal "cord_gauge", precision: 12, scale: 3
    t.decimal "fabric_wt", precision: 12, scale: 3
    t.decimal "compound_wt", precision: 12, scale: 3
    t.decimal "total_fabric_wt", precision: 12, scale: 3
    t.string "doc_no"
  end

  create_table "uom_masters", force: :cascade do |t|
    t.string "uom", limit: 4
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wh_material_storages", force: :cascade do |t|
    t.string "ge_doc_no"
    t.string "plant"
    t.string "str_loc"
    t.string "mat_group"
    t.string "mat_code"
    t.string "mat_desc"
    t.string "mat_uom"
    t.string "grn_no"
    t.float "grn_qty"
    t.datetime "grn_date"
    t.string "vendor_batch"
    t.datetime "mfg_date"
    t.datetime "expiry_dt"
    t.string "wh_loc_id"
    t.string "wh_loc_rfid"
    t.float "wh_loc_qty"
    t.float "wh_picked_qty"
    t.float "wh_balance_qty"
    t.string "wh_hold_reason"
    t.string "sup_roll_ref"
    t.string "vendor_code"
    t.string "vendor_name"
    t.string "sap_batch"
    t.string "sap_status"
    t.string "stock_status"
    t.string "status"
    t.string "action_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sup_gross_wt"
    t.string "sup_net_wt"
    t.string "sup_length_mtr"
    t.string "sap_inspection_lot_ref"
    t.string "ud_code", limit: 10, default: ""
    t.decimal "ur_qty", precision: 12, scale: 3
    t.decimal "bl_qty", precision: 12, scale: 3
    t.string "ud_status", limit: 1, default: "N"
    t.datetime "ud_transfer_dt"
    t.string "ud_err_msg", limit: 50, default: ""
  end

end
