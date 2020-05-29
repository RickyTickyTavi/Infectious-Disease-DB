:- discontiguous disease/1.
:- discontiguous test/2.
:- discontiguous symptom/2.
:- discontiguous locale/2.
:- discontiguous treatment/2.






%Mainprogram

run :-
write('Welcome to the disease diagnostic center'), nl,
write('Please enter symptoms now. Enter "DONE" when finished.'),nl,
write('Enter everything as it is in the .pl database. E.G. north_america.'),nl,
read_all(Symptoms),
write('Enter the locations you have visited in the past couple months: enter DONE when finished.'),nl,
read_all(Locations),
propose_diseases(Symptoms,Locations,Diseases),
write('You may have any or all of these diseases:'),nl,nl,
write(Diseases),nl, nl,
propose_tests(Diseases,Tests),
write('These are the possible tests you can take'),nl,nl,
write(Tests),nl,nl,
write('Enter tests you took and the results in this format. antibody_test. positive.  repeat this format for more tests'),nl,
write('Enter DONE when finished'), nl,nl,
read_all(Results), % [ "PCR", "Positive", ... ]
make_tuples(Results, Results_tuples),
filter(Diseases,Results_tuples,FinalList),
write('You may have these diseases:'),nl,
write(FinalList),nl,
propose_treatments(FinalList, Treatments),
write('The recommended treatments for your disease(s) are:'),nl,
write(Treatments).


read_all(List) :-
  read(Item),
  helper(Item,List).
helper("DONE",[]) :- !.
helper(Item,[Item|List]) :-
  read_all(List).


match(D, Symptoms, Locations) :-
  symptom(D,S),
  member(S,Symptoms),
  locale(D,L),
  (L = all ; member(L,Locations)).

propose_diseases(Symptoms,Locations,Diseases) :-
  findall(D, (disease(D), match(D,Symptoms,Locations)), WithDups),
  sort(WithDups, Diseases).

propose_tests(Diseases, Tests) :-
  findall(Test, (test(D,Test), member(D,Diseases)), WithDups),
  sort(WithDups, Tests). % Getting rid of duplicates.

propose_treatments(Diseases, Treatments) :-
  findall(T, (treatment(D,T), member(D, Diseases)), WithDups),
  sort(WithDups, Treatments).

make_tuples([],[]).
make_tuples([Test, Outcome | Tail], [(Test, Outcome) | ResTail]) :-
  make_tuples(Tail, ResTail).

filter([],_,[]).
filter([D | Diseases], Results, [D | Rest]) :-
  test(D,T),
  member( (T,positive), Results), !,
  filter(Diseases, Results, Rest).
filter([ _ | Diseases], Results, Rest) :-
  filter(Diseases, Results, Rest).













%Disease database



%Gonorrhea
disease(gonorrhea).

symptom(gonorrhea, urethritic).
symptom(gonorrhea, salpingitis).
symptom(gonorrhea, cervicitis).
symptom(gonorrhea, pharyngitis).
symptom(gonnorrhea, aysmptomatic).

test(gonorrhea, gram-negative).

locale(gonorrhea,all).

treatment(gonorrhea, ceftriaxone).
treatment(gonorrhea, azithromycin).
treatment(gonorrhea, doxycycline).

%Ehrlichiosis
disease(ehrlichiosis).

symptom(ehrlichiosis, muscle_ache).
symptom(ehrlichiosis, fever).
symptom(ehrlichiosis, confusion).
symptom(ehrlichiosis, vomiting).

test(ehrlichiosis, blood_test).
test(ehrlichiosis, liver_test).

locale(ehrlichiosis, north_america).

treatment(ehrlichiosis, doxycycline).



%DENGUE
disease(dengue).

symptom(dengue, headache).
symptom(dengue, fever).
symptom(dengue, skin_rash).

test(dengue, viral_antigen_detection).
test(dengue, pcr).

locale(dengue, south_america).
locale(dengue, south_africa).
locale(dengue, southeast_asia).

treatment(dengue, acetaminophen).
treatment(dengue, blood_transfusion).


%Rheumatic Fever
disease(rheumatic_fever).

symptom(rheumatic_fever, swollen_lymph_nodes).
symptom(rheumatic_fever, nosebleed).
symptom(rheumatic_fever, swollen_tonsils).
symptom(rheumatic_fever, nausea).
symptom(rheumatic_fever, arthritis).

test(rheumatic_fever, ekg).
test(rheumatic_fever, echocardiography).

locale(rheumatic_fever, all).

treatment(rheumatic_fever, antibiotics).


%SARS
disease(sars).

symptom(sars, fever).
symptom(sars, difficulty_breathing).
symptom(sars, muscle_ache).
symptom(sars, malaise).

test(sars, pcr).
test(sars, antibody_test).

locale(sars, all).

treatment(sars, tracheal_intubation).
treatment(sars, oxygen_therapy).


%powassan
disease(powassan).

symptom(powassan, fever).
symptom(powassan, vomiting).
symptom(powassan, encephalitis).
symptom(powassan, meningitis).
symptom(powassan, confusion).
symptom(powassan, seizures).

test(powassan, cerebrospinal_fluid).

locale(powassan, north_america).
locale(powassan, canada).
locale(powassan, russia).

treatement(powassan, corticosteroids).
treatment(powassan, intravenous_fluids).



%Heartland Virus:
disease(heartland_virus).

symptom(heartland_virus, fever).
symptom(heartland_virus, lethargy).
symptom(heartland_virus, headache).
symptom(heartland_virus, muscle_pain).
symptom(heartland_virus, nausea).
symptom(heartland_virus, loss_of_appetite).
symptom(heartland_virus, diarrhea).
symptom(heartland_virus, weight_loss).
symptom(heartland_virus, arthritis).
symptom(heartland_virus, low_white_blood_cell_count).

test(heartland_virus, antibody_titer).

locale(heartland_virus, united_states).

treatment(heartland_virus, pain_relief_medication).
 

 
%Whooping Cough (pertussis):
disease(pertussis).

symptom(pertussis, paroxysmal_cough).
symptom(pertussis, inspiratory_whoop).
symptom(pertussis, fainting).
symptom(pertussis, vomiting).

test(pertussis, nose_swab).

locale(pertussis,all).

treatment(pertussis, erythromycin).
treatment(pertussis, clarithromycin).
treatment(pertussis, azithromycin).



%Shingles:
disease(shingles).

symptom(shingles, headache).
symptom(shingles, fever).
symptom(shingles, malaise).
symptom(shingles, headache).
symptom(shingles, itching).
symptom(shingles, hyperesthesia).
symptom(shingles, paresthesia).
 
test(shingles, igm).
test(shingles, pcr).

locale(shingles,all).

treatment(shingles, calamine).
treatment(shingles, aciclovir).
treatment(shingles, valaciclovir).
treatment(shingles, famciclovir).
treatment(shingles, corticosteroids).



%Isosporiasis:
disease(isosporiasis).

symptom(isosporiasis, diarrhea).
symptom(isosporiasis, abdominal_cramps).

test(isosporiasis, stool_test).
test(isosporiasis, biopsy).
test(isosporiasis, string_epifluorescence).

locale(isosporiasis,all).

treatment(isosporiasis, trimethorprim_sulfamethoxazole).

 

%Malaria:
disease(malaria).

symptom(malaria, headache).
symptom(malaria, fever).
symptom(malaria, shivering).
symptom(malaria, arthritis).
symptom(malaria, vomiting).
symptom(malaria, hemolytic_anemia).
symptom(malaria, jaundice).
symptom(malaria, hemoglobin_in_urine).
symptom(malaria, retinal_damage).
symptom(malaria, convulsions).

test(malaria,  low_number_platelets).
test(malaria, high_bilirubin).
test(malaria, blood_film).
test(malaria, ridt).

locale(malaria, namibia).
locale(malaria, nepal).
locale(malaria, nicaragua).
locale(malaria, niger).
locale(malaria, nigeria).
locale(malaria, north_korea).
locale(malaria, namibia).

treatment(malaria, chloroquine).
treatment(malaria, anodiaquine).
treatment(malaria, pyrimethamine).
treatment(malaria, proguanil).
treatment(malaria, sufonamindes).
treatment(malaria, mefloquine).
treatment(malaria, atovaquone).
treatment(malaria, primaquine).
treatment(malaria, halofantrine).
treatment(malaria, doxycycline).
treatment(malaria, clindamycin).




%AFM
disease(afm).

symptom(afm, drooping_face).
symptom(afm, slurred_speech).
symptom(afm, difficulty_swallowing).

locale(afm, all).

test(afm, mri).
test(afm, csf).

treatment(afm, none).




%Ciguatera
disease(ciguatera).

symptom(ciguatera, nausea).
symptom(ciguatera, vomiting).
symptom(ciguatera, diarrhea).
symptom(ciguatera, numb_face).

locale(ciguatera, carribean).

test(ciguatera, rba).

treatment(ciguatera, stomach_pump).



%Rickettsiosis
disease(rickettsiosis).

symptom(rickettsiosis, nausea).
symptom(rickettsiosis, vomiting).
symptom(rickettsiosis, fever).
symptom(rickettsiosis, headache).
symptom(rickettsiosis, death).

locale(rickettsiosis, north_america).

test(rickettsiosis, serology_test).

treatment(rickettsiosis, antibiotics).



%Marburg fever
disease(marburg_fever).

symptom(marburg_fever, jaundice).
symptom(marburg_fever, fever).
symptom(marburg_fever, abdominal_pain).
symptom(marburg_fever, headache).

locale(marburg_fever, uganda).

test(marburg_fever, pcr).

treatment(marburg_fever, icu).



%yersiniosis
disease(yersiniosis).

symptom(yersiniosis, bacterimia).
symptom(yersiniosis, fever).
symptom(yersiniosis, diarrhea).
symptom(yersiniosis, abdominal_pain).

locale(yersiniosis, all).

test(yersiniosis, gram-negative).

treatment(yersiniosis, doxycycline).



%Sepsis:
disease(sepsis).

symptom(sepsis, fever).
symptom(sepsis, rapid_blood_rate).
symptom(sepsis, low_body_temperature).
symptom(sepsis, high_blood_sugar).
symptom(sepsis, edema).
symptom(sepsis, confusion).

test(sepsis, white_blood_cell_counts).
test(sepsis, pcr).
test(sepsis, blood_culture).
test(sepsis, measuring_serum_lactate).

locale(sepsis, all).

treatment(sepsis, antibiotics).
treatment(sepsis, intravenous_fluids).
treatment(sepsis, blood_products).
treatment(sepsis, vasopressors).
treatment(sepsis, steroids).
treatment(sepsis, anesthesia).


%Coccidioidomycosis:
disease(coccidioidomycosis).

symptom(coccidioidomycosis, tiredness).
symptom(coccidioidomycosis, fever).
symptom(coccidioidomycosis, cough).
symptom(coccidioidomycosis, headache).
symptom(coccidioidomycosis, rash).
symptom(coccidioidomycosis, muscle_ache).
symptom(coccidioidomycosis, joint_pain).

test(coccidioidomycosis, pcr).
test(coccidioidomycosis, chest_x-ray).

locale(coccidioidomycosis, north_america).

treatment(coccidioidomycosis, anti-fungal_therapy).
treatment(coccidioidomycosis, fluconazole).
treatment(coccidioidomycosis, amphotericin_B).

 

%Bacterial Vaginosis:
disease(bacterial_vaginosis).
 
symptom(bacterial_vaginosis, vaginal_discharge).
symptom(bacterial_vaginosis, itching).
symptom(bacterial_vaginosis, asymptomatic).
symptom(bacterial_vaginosis, fishy_smell).

test(bacterial_vaginosis, gram-stain).
test(bacterial_vaginosis, nugent_score).
test(bacterial_vaginosis, arnsel_criteria).

locale(bacterial_vaginosis, all).

treatment(bacterial_vaginosis, antibiotics).
treatment(bacterial_vaginosis, probiotics).



%Leprosy:
disease(leprosy).

symptom(leprosy, patches).
symptom(leprosy, tissue_loss).
symptom(leprosy, nerve_problems).
symptom(leprosy, joint_deformity).
symptom(leprosy, numbness).

test(leprosy, pcr).
test(leprosy, biopsy).

locale(leprosy, all).

treatment(leprosy, mdt).
treatment(leprosy, dapsone).
treatment(leprosy, clofazimine).
treatment(leprosy, rifampicin).



%Cholera
disease(cholera).

symptom(cholera, diarrhea).
symptom(cholera, vomiting).
symptom(cholera, rapid_heart_rate).
symptom(cholera, skin_elasticity).
symptom(cholera, dry_mucous_membranes).
symptom(cholera, low_blood_pressure).
symptom(cholera, thirst).
symptom(cholera, muscle_ache).
symptom(cholera, restlessness).
symptom(cholera, acute_renal_failure).
symptom(cholera, coma).

test(cholera, vibrio_cholerae_o1).

treatment(cholera, rehydration_therapy).
treatment(cholera, doxycycline).
treatment(cholera, azithromycin).
treatment(cholera, zinc).
treatment(cholera, azithromycin).

locale(cholera, africa).
locale(cholera, southeast_asia).
locale(cholera, united_states).
locale(cholera, haiti).



%Lyme Disease
disease(lyme).

symptom(lyme, fever).
symptom(lyme, shivering).
symptom(lyme, headache).
symptom(lyme, swollen_lymph_nodes).
symptom(lyme, erythema_migrains_rash).
symptom(lyme, neck_stiffness).
symptom(lyme, arthritis).
symptom(lyme, facial_palsy).
symptom(lyme, nerve_pain).
symptom(lyme, memory_loss).

test(lyme, tick_exposure).
test(lyme, eia).
test(lyme, western_blot).

treatment(lyme, doxycycline).
treatment(lyme, cefuroxime_axetil).
treatment(lyme, amoxicillin).

locale(lyme, united_states).



%Vibriosis
disease(vibriosis).

symptom(vibriosis, diarrhea).
symptom(vibriosis, abdominal_cramps).
symptom(vibriosis, nausea).
symptom(vibriosis, vomiting).
symptom(vibriosis, fever).
symptom(vibriosis, shivering).

test(vibriosis, vibrio).

treatment(vibriosis, hydration).

locale(vibriosis, all).



%Toxic shock syndrome (other than streptococcal)
disease(toxic_shock_syndrome).

symptom(toxic_shock_syndrome, fever).
symptom(toxic_shock_syndrome, rash).
symptom(toxic_shock_syndrome, desquamation).
symptom(toxic_shock_syndrome, hypotension).
symptom(toxic_shock_syndrome, vomiting).
symptom(toxic_shock_syndrome, diarrhea).
symptom(toxic_shock_syndrome, myalgia).
symptom(toxic_shock_syndrome, hyperemia).
symptom(toxic_shock_syndrome, confusion).

locale(toxic_shock_syndrome, all).

test(toxic_shock_syndrome, serology_test).
test(toxic_shock_syndrome, blood_culture).

treatment(toxic_shock_syndrome, antibiotics).
treatment(toxic_shock_syndrome, intravenous_fluids).
treatment(toxic_shock_syndrome, wound_cleaning).
treatment(toxic_shock_syndrome, respirator).


%Psittacosis
disease(psittacosis).

symptom(psittacosis, fever).
symptom(psittacosis, shivering).
symptom(psittacosis, headache).
symptom(psittacosis, myalgia).
symptom(psittacosis, cough).

locale(psittacosis, all).

test(psittacosis, cft).

treatment(psittacosis, antibiotic).


%Leptospirosis
disease(leptospirosis).

symptom(leptospirosis, fever).
symptom(leptospirosis, headache).
symptom(leptospirosis, shivering).
symptom(leptospirosis, muscle_ache).
symptom(leptospirosis, vomiting).
symptom(leptospirosis, jaundice).
symptom(leptospirosis, red_eyes).
symptom(leptospirosis, abdominal_pain).
symptom(leptospirosis, diarrhea).
symptom(leptospirosis, rash).

locale(leptospirosis, all).

test(leptospirosis, mat).
test(leptospirosis, sold_phase_assay).

treatment(leptospirosis, antibiotic).



%Invasive Pneumococcal Disease (pneumonia)
disease(pneumonia).

symptom(pneumonia, shivering).
symptom(pneumonia, fever).
symptom(pneumonia, rapid_breathing).
symptom(pneumonia, difficulty_breathing).
symptom(pneumonia, chest_pain).

locale(pneumonia, all).

test(pneumonia, chest_x-ray).
test(pneumonia, blood_culture).

treatment(pneumonia, antibiotic).



%Meningococcal Disease 
disease(meningococcal-disease).

symptom(meningococcal-disease, blood-clotting).
symptom(meningococcal-disease, rash).
symptom(meningococcal-disease, bruising).
symptom(meningococcal-disease, meningeal-inflammation).

test(meningococcal-disease, gram-negative).
test(meningococcal-disease, glass-test).

locale(meningococcal-disease, all).

treatment(meningococcal-disease, vaccination).
treatment(meningococcal-disease, benzylpenicillin).
treatment(meningococcal-disease, cefotaxime).
treatment(meningococcal-disease, ceftriaxone).

 

%Q Fever
disease(q-fever).

symptom(q-fever, fever).
symptom(q-fever, malaise).
symptom(q-fever, profuse-perspiration).
symptom(q-fever, severe-headache).
symptom(q-fever, muscle-ache).
symptom(q-fever, joint-pain).
symptom(q-fever, loss-of-appetite).
symptom(q-fever, upper-respiratory).
symptom(q-fever, cough).
symptom(q-fever, pleuritic-pain).
symptom(q-fever, shivering).
symptom(q-fever, confusion).
symptom(q-fever, nausea).
symptom(q-fever, vomiting).
symptom(q-fever, diarrhea).
symptom(q-fever, asymptomatic).

test(q-fever, blood_test).

locale(q-fever, all).

treatment(q-fever, doxycycline).
treatment(q-fever, tetracycline).
treatment(q-fever, chloramphenicol).
treatment(q-fever, ciprofloxacin).
treatment(q-fever, ofloxacin).
treatment(q-fever, hydroxychloroquine).
treatment(q-fever, quinolones).
treatment(q-fever, co-trimoxazole).

 

%Trichinellosis
disease(trichinellosis).

symptom(trichinellosis, eosinophilia).
symptom(trichinellosis, fever).
symptom(trichinellosis, myalgia).
symptom(trichinellosis, edema).

test(trichinellosis, biopsy).
test(trichinellosis, blood_test).

locale(trichinellosis, all).

treatment(trichinellosis, mebendazole).
treatment(trichinellosis, albendazole).
treatment(trichinellosis, prednisone).

 

%Cryptosporidiosis
disease(cryptosporidiosis).

symptom(cryptosporidiosis, diarrhea).
symptom(cryptosporidiosis, fever).
symptom(cryptosporidiosis, abdominal_pain).
symptom(cryptosporidiosis, dehydration).
symptom(cryptosporidiosis, weight_loss).
symptom(cryptosporidiosis, fatigue).
symptom(cryptosporidiosis, nausea).
symptom(cryptosporidiosis, vomiting).
symptom(cryptosporidiosis, epigastric_tenderness).
symptom(cryptosporidiosis, arthritis).
symptom(cryptosporidiosis, jaundice).
symptom(cryptosporidiosis, ascites).
symptom(cryptosporidiosis, inflammation).
symptom(cryptosporidiosis, nasal_congestion).
symptom(cryptosporidiosis, hoarseness).
symptom(cryptosporidiosis, cough).
symptom(cryptosporidiosis, difficulty_breathing).
symptom(cryptosporidiosis, hypoxemia).

test(cryptosporidiosis, microscopy).
test(cryptosporidiosis, staining).
test(cryptosporidiosis, blood_test).

locale(cryptosporidiosis, all).

treatment(cryptosporidiosis, nitazoxanide).
treatment(cryptosporidiosis, paromomycin).
treatment(cryptosporidiosis, azithromycin).




%Listeriosis
disease(listeriosis).

symptom(listeriosis, fever).
symptom(listeriosis, muscle-ache).
symptom(listeriosis, diarrhea).
symptom(listeriosis, headache).
symptom(listeriosis, stiff-neck).
symptom(listeriosis, confusion).
symptom(listeriosis, loss-of-balance).
symptom(listeriosis, convulsions).

test(listeriosis, blood_test).
test(listeriosis, cerebrospinal-fluid).

locale(listeriosis, all).

treatment(listeriosis, ampicillin).
treatment(listeriosis, gentamicin).



%Tularemia
disease(tularemia).

symptom(tularemia, fever).
symptom(tularemia, skin_ulcers).
symptom(tularemia, swollen_lymph_nodes).
symptom(tularemia, pneumonia).
symptom(tularemia, throat_infection).

test(tularemia, lymph_node_biops).

locale(tularemia,all).

treatment(tularemia, streptomycin).
treatment(tularemia, gentamicin).
treatment(tularemia, doxycycline).

%Hepatitis A
disease(hepatitis_a).

symptom(hepatitis_a, nausea).
symptom(hepatitis_a, vomiting).
symptom(hepatitis_a, diarrhea).
symptom(hepatitis_a, jaundice).
symptom(hepatitis_a, fever).
symptom(hepatitis_a, abdominal_pain).
symptom(hepatitis_a, acute_liver_failure).
symptom(hepatitis_a, dark_urine).

test(hepatitis_a, blood_test).

locale(hepatitis_a, all).

treatment(hepatitis_a, no_known_treatment).
treatment(hepatitis_a, fluid_replacement).
treatment(hepatitis_a, comfort_care).

%HPV
disease(hpv).

symptom(hpv, genital_warts).
symptom(hpv, legions).
symptom(hpv, cervical_cancer).
symptom(hpv, jaundice).
symptom(hpv, laryngeal_papillomatosis).

test(hpv, mouth_test).

locale(hpv, all).

treatment(hpv, no_known_treatment).



%Lassa Fever
disease(lassa_fever).

symptom(lassa_fever, fever).
symptom(lassa_fever, headaches).
symptom(lassa_fever, gastrointestinal_bleeding).
symptom(lassa_fever, deafness).
symptom(lassa_fever, muscle_ache).

test(lassa_fever, cell_culture).

locale(lassa_fever, west_africa).

treatment(lassa_fever, ribavirin).



%Tetanus
disease(tetanus).

symptom(tetanus, lockjaw).
symptom(tetanus, fever).
symptom(tetanus, difficulty_swallowing).
symptom(tetanus, elevated_heart_rate).
symptom(tetanus, muscle_spasms).

test(tetanus, spatula_test).

locale(tetanus, all).

treatment(tetanus, tetanus_immunoglobulin).
treatment(tetanus, metronidazole).
treatment(tetanus, diazepam).




%EBOLA:
disease(ebola).

symptom(ebola, fever).
symptom(ebola, bleeding).
symptom(ebola, flushing).
symptom(ebola, spots).
symptom(ebola, swelling).
symptom(ebola, low_blood_pressure).
symptom(ebola,vomiting).

locale(ebola, central_africa).

test(ebola, ptt).

treatment(ebola, ribovarin).

 

%ZIKA:
disease(zika).

symptom(zika,rash).
symptom(zika,fever).
symptom(zika,dengue_fever).

locale(zika,uganda).
locale(zika,nigeria).

test(zika,elisa_test).
test(zika,pcr).

 

%SLEEPING SICKNESS:
disease(sleeping_sickness).

symptom(sleeping_sickness, fever).
symptom(sleeping_sickness, headaches).
symptom(sleeping_sickness, joint_pain).
symptom(sleeping_sickness, itching).
symptom(sleeping_sickness, swelling).

locale(sleeping_sickness, central_africa).

test(sleeping_sickness, microscopy).

treatment(sleeping_sickness, nec_treatment).



%Brucellosis:
disease(brucellosis).

symptom(brucellosis, night-sweats).
symptom(brucellosis, arthralgia).
symptom(brucellosis, headache).
symptom(brucellosis, fatigue).
symptom(brucellosis, myalgia).
symptom(brucellosis, weight_loss).
symptom(brucellosis, arthritis).
symptom(brucellosis, meningitis).
symptom(brucellosis, endocarditis).
symptom(brucellosis, orchitis).
symptom(brucellosis, hepatomegaly).
symptom(brucellosis, splenomegaly).

test(brucellosis, brucella-positive-culture).
test(brucellosis, serum-antibody-count).
test(brucellosis, pcr_assay).

locale(brucellosis, all).

treatment(brucellosis, antibiotics).

%Campylobacteriosis:
disease(campylobacteriosis).

symptom(campylobacteriosis, diarrhea).
symptom(campylobacteriosis, abdominal-cramps).
symptom(campylobacteriosis, malaise).
symptom(campylobacteriosis, fever).
symptom(campylobacteriosis, nausea).
symptom(campylobacteriosis, vomiting).
symptom(campylobacteriosis, guillain-barre-syndrome).
symptom(campylobacteriosis, reactive-arthritis).
symptom(campylobacteriosis, irritable-bowel-syndrom).

test(campylobacteriosis, cidt).

locale(campylobacteriosis, all).

treatment(campylobacteriosis, rest).
treatment(campylobacteriosis, antibiotics).




%Giardiasis:

symptom(giardiasis, diarrhea).
symptom(giardiasis, abdominal_cramps).
symptom(giardiasis, bloating).
symptom(giardiasis, weight_loss).
symptom(giardiasis, malabsorption).

test(giardiasis, stool).
test(giardiasis, intestinal_fluid).
test(giardiasis, tissue).
test(giardiasis, biopsy).

locale(giardiasis, all).

treatment(giardiasis, metronidazole).
treatment(giardiasis, tinidazole).
treatment(giardiasis, secnidazole).
treatment(giardiasis, ornidazole).


%Varicella
disease(varicella).

symptom(varicella, maculo-papulovesicular_rash).
symptom(varicella, fever).
symptom(varicella, loss_of_appetite).
symptom(varicella, fatigue).
symptom(varicella, pneumonia).
symptom(varicella, blood_vessel_inflammation).
symptom(varicella, encephalitis).
symptom(varicella, meningitis).

test(varicella, specimen-isolation).
test(varicella, immunofluorescence).
test(varicella, pcr).
test(varicella, varicella_test).

locale(varicella, all).

treatment(varicella, acyclovir).
treatment(varicella, valacyclovir).
treatment(varicella, aciclovir).



 

%Norovirus
disease(norovirus).

symptom(norovirus, diarrhea).
symptom(norovirus, abdominal_pain).
symptom(norovirus, vomiting).
symptom(norovirus, headache).

test(norovirus, pcr_assay).
test(norovirus, elisa_test).

locale(norovirus, all).

treatment(norovirus, hydration).
treatment(norovirus, antiemetics).
treatment(norovirus, antidiarrheals).




%Anthrax
disease(anthrax).

 
symptom(anthrax,diarrhea).
symptom(anthrax,cough).
symptom(anthrax,sore_throat).
symptom(anthrax,fatigue).
symptom(anthrax,vomiting).

test(anthrax,blood_test).
test(anthrax,cerebrospinal_fluid).

locale(anthrax,all).

treatment(anthrax,ciprofloxacin).
treatment(anthrax,doxycycline).
treatment(anthrax,obiltoxaximab).
treatment(anthrax,raxibacumab).



%Rabies:
disease(rabies).

symptom(rabies, fever).
symptom(rabies, headache).
symptom(rabies, hallucinations).
symptom(rabies, insomnia).
symptom(rabies, partial_paralysis).

test(rabies, tissue_collection).

locale(rabies,all).

treatment(rabies, none).



%Salmonellosis:
disease(salmonellosis).

symptom(salmonellosis, cramps).
symptom(salmonellosis,  diarrhea).
symptom(salmonellosis, fever).
symptom(salmonellosis, nausea).
symptom(salmonellosis,  vomiting).

test(salmonellosis, stool_test).

locale(salmonellosis, all).

treatment(salmonellosis, antibiotics).
treatments(salmonellosis, iv).



%Astrovirus
disease(astrovirus).

symptom(astrovirus, diarrhea).
symptom(astrovirus, nausea).
symptom(astrovirus, vomiting).
symptom(astrovirus, fever).

test(astrovirus, electron_microscopy).
test(astrovirus, immunofluorescence).

locale(astrovirus, all).

treatment(astrovirus, immunuoglobulin).
treatment(astrovirus, achyrocline_bogotensis).



%Babesiosis
disease(babesiosis).

symptom(babesiosis, fever).
symptom(babesiosis, hemolytic_anemia).
symptom(babesiosis, malaise).
symptom(babesiosis, fatigue).

test(babesiosis, maltese_cross-formations).
test(babesiosis, serology_test).
test(babesiosis, pcr).

locale(babesiosis, all).

treatment(babesiosis, atovaquone).
treatment(babesiosis, azithromycin).



%Blastocytosis
disease(blastocytosis).

symptom(blastocytosis, abdominal_pain).
symptom(blastocytosis, itching).
symptom(blastocytosis, constipation).
symptom(blastocytosis, diarrhea).

test(blastocytosis, ova_parasite_exam).
test(blastocytosis, pcr).

locale(blastocytosis, north_america).
locale(blastocytosis, europe).
locale(blastocytosis, asia).

treatment(blastocytosis, metronidazole).
treatment(blastocytosis, trimethoprim).



%Filariasis
disease(filariasis).

symptom(filariasis, elephantiasis).
symptom(filariasis, rash).
symptom(filariasis, river_blindness).

test(filariasis, finger_prick_test).
test(filariasis, blood_film).

locale(filariasis, all).

treatment(filariasis, albendazole).
treatment(filariasis, ivermectin).



%Influenza:
disease(influenza).

symptom(influenza,fever).
symptom(influenza,muscle_ache).
symptom(influenza,shivering).
symptom(influenza,headache).
symptom(influenza,cough).
symptom(influenza,fatigue).
symptom(influenza,nasal_congestion).
symptom(influenza,sore_throat).

test(influenza,ridt).

locale(influenza,all).

treatment(influenza,zanamivir).
treatment(influenza,oseltamivir).
treatment(influenza,peramivir).



%% MEASLES %%
disease(measles).
 
symptom(measles,fever).
symptom(measles,cough).
symptom(measles,runny_nose).
symptom(measles,inflammation_of_eyes).
symptom(measles,rash).
 
locale(measles,europe).
locale(measles,central_asia).
locale(measles,east_asia).
locale(measles,north_america).
locale(measles,africa).
 
test(measles,rubeola_antibody_blood_test).
test(measles,measles_immunity_test).
test(measles,physical_examination).
 
treatment(measles,drinking_fluids).
treatment(measles,rest).
 
 
%% TYPHOID %%
disease(typhoid).
 
symptom(typhoid,myalgia).
symptom(typhoid,bloating).
symptom(typhoid,constipation).
symptom(typhoid,nausea).
symptom(typhoid,vomiting).
symptom(typhoid,fatigue).
symptom(typhoid,fever).
symptom(typhoid,shivering).
symptom(typhoid,loss_of_appetite).
symptom(typhoid,malaise).
 
locale(typhoid,central_asia).
locale(typhoid,east_asia).
locale(typhoid,north_america).
 
test(typhoid,blood_test).
 
treatment(typhoid,antibiotics).
 
 
%% MUMPS %%
disease(mumps).
 
symptom(mumps,fever).
symptom(mumps,malaise).
symptom(mumps,headache).
symptom(mumps,parotid_gland_swelling).
 
locale(mumps, all).
 
test(mumps,elisa_test).
test(mumps,ifa).
test(mumps,igm).
 
treatment(mumps,icing_neck).
treatment(mumps,heating_neck).
treatment(mumps,acetaminophin).
 
 
%% MENINGITIS %%
disease(meningitis).
 
symptom(meningitis,headache).
symptom(meningitis,fever).
symptom(meningitis,stiff_neck).
symptom(meningitis,loss_of_appetite).
symptom(meningitis,fatigue).
symptom(meningitis,vomiting).
 
locale(meningitis, all).
 
treatment(meningitis,antibiotics).
treatment(meningitis,steroid).
treatment(meningitis,penicillin).
treatment(meningitis,hospitalization).
treatment(meningitis,oxygen_therapy).
 
test(meningitis,blood_culture).
test(meningitis,computerizedtomography).
test(meningitis,lumbarpuncture).
 
 
%% CHICKENPOX %%
disease(chickenpox).
 
symptom(chickenpox,fever).
symptom(chickenpox,tired).
symptom(chickenpox,headache).
symptom(chickenpox,pneumonia).
symptom(chickenpox,inflammation_of_brain).
symptom(chickenpox,bacterial_skin_infection).
symptom(chickenpox,rash).
 
locale(chickenpox, all).
 
test(chickenpox,varicella_test).
test(chickenpox,elisa_test).
 
treatment(chickenpox,antihistamines).
treatment(chickenpox,topical_ointments).


%Diphteria
disease(diphteria).

symptom(diphteria, fatigue).
symptom(diphteria, sore_throat).
symptom(diphteria, fever).
symptom(diphteria, swollen_lymph_nodes).

locale(diphteria,north_america).

test(diphteria,throat_swab).
test(diphteria,skin_lesion).

treatment(diphteria,diphteria_antitoxin).


%Botulism
disease(botulism).

symptom(botulism, double_vision).
symptom(botulism, blurred_vision).
symptom(botulism, drooping_eyelids).
symptom(botulism, slurred_speech).
symptom(botulism, difficulty_swallowing).
symptom(botulism, difficulty_breathing).
symptom(botulism,  a_thick_feeling_tongue).
symptom(botulism, dry_mouth).
symptom(botulism, muscle_weakness).

locale(botulism,all).

test(botulism, brain_scan).
test(botulism, spinal_fluid).
test(botulism, ncs).
test(botulism, emg).

treatment(botulism, antitoxin).
treatment(botulism, antibiotics).
treatment(botulism, breathing_assistance).
treatment(botulism, antitoxin).
treatment(botulism, rehabilitation).



%Chlamydia Pneumoniae Infection
disease(chlamydia).

symptom(chlamydia,runny_nose).
symptom(chlamydia,stuffy_nose).
symptom(chlamydia,low_grade_fever).
symptom(chlamydia,laryngitis).
symptom(chlamydia,sore_throat).
symptom(chlamydia,headache).
symptom(chlamydia,slowly_worsening_cough).

locale(chlamydia,all).

test(chlamydia,nose_swab).
test(chlamydia,throat_swab).

treatment(chlamydia,macrolides).
treatment(chlamydia,tetracylines).
treatment(chlamydia,fluoroquionolones).


%Cyclosporiasis(Cyclospora Infection).
disease(cyclosporiasis).

symptom(cyclosporiasis, diarrhea).
symptom(cyclosporiasis,loss_of_appetite).
symptom(cyclosporiasis, weight_loss).
symptom(cyclosporiasis, cramping).
symptom(cyclosporiasis, bloating).
symptom(cyclosporiasis, increased_gas).
symptom(cyclosporiasis, nausea).
symptom(cyclosporiasis, fatigue).

locale(cyclosporiasis,all).

test(cyclosporiasis, stool_specimens).

treatment(cyclosporiasis,trimethoprim).
treatment(cyclosporiasis,sulfamethoxazole).



%Rotavirus (stomach flu)
disease(rotavirus).

symptom(rotavirus, nausea).
symptom(rotavirus, vomiting).
symptom(rotavirus, diarrhea).
symptom(rotavirus, low_grade_fever).

test(rotavirus, enzyme_immunoassay).

locale(rotavirus, all).

treatment(rotavirus, management_of_dehydration).



%Rhinovirus (common cold)
disease(rhinovirus).

symptom(rhinovirus, sore_throat).
symptom(rhinovirus, runny_nose).
symptom(rhinovirus, nasal_congestion).
symptom(rhinovirus, sneezing).
symptom(rhinovirus, cough).
symptom(rhinovirus, muscle_ache).
symptom(rhinovirus, fatigue).
symptom(rhinovirus, malaise).
symptom(rhinovirus, headache).
symptom(rhinovirus, muscle_weakness).
symptom(rhinovirus, loss_of_appetite).
symptom(rhinovirus, low_grade_fever).

test(rhinovirus, none).

locale(rhinovirus, all).

treatment(rhinovirus, prevention).



%Infectious mononucleosis (Epstein-Barr virus (EBV))
disease(ebv).

symptom(ebv, asymptomatic).
symptom(ebv, fever).
symptom(ebv, sore_throat).
symptom(ebv, swollen_lymph_nodes).
symptom(ebv, fatigue).

test(ebv, blood_test).

locale(ebv, all).

treatment(ebv, management_of_pain).
treatment(ebv, management_of_dehydration).



%Chikungunya
disease(chikungunya).

symptom(chikungunya, fever).
symptom(chikungunya, joint_pain).
symptom(chikungunya, headache).
symptom(chikungunya, muscle_ache).
symptom(chikungunya, joint_swelling).
symptom(chikungunya, rash).

test(chikungunya, blood_test).
test(chikungunya, blood_antibodies).

locale(chikungunya, all).

treatment(chikungunya, supportive_care).



%Shigellosis
disease(shigellosis). 

symptom(shigellosis, diarrhea).
symptom(shigellosis, fever). 
symptom(shigellosis, stomach_pain). 

test(shigellosis, shigella). 

locale(shigellosis, all). 

treatment(shigellosis, bismuth_subsalicylate). 



%Argentine Hemorrhagic Fever
disease(argentine_hemorrhagic_fever).

symptom(argentine_hemorrhagic_fever, fever).
symptom(argentine_hemorrhagic_fever, skin_dyseesthesia).
symptom(argentine_hemorrhagic_fever, oral_ulcerations).
symptom(argentine_hemorrhagic_fever, chest_pain).
symptom(argentine_hemorrhagic_fever, sore_throat).
symptom(argentine_hemorrhagic_fever, conjecutival_redness).
symptom(argentine_hemorrhagic_fever, nausea).

test(argentine_hemorrhagic_fever, blood_test).

locale(argentine_hemorrhagic_fever, south_america).

treatment(argentine_hemorrhagic_fever, ribavirin).



%Balantidiasis
disease(balantidiasis).

symptom(balantidiasis, diarrhea).
symptom(balantidiasis, dysentery).
symptom(balantidiasis, abdominal_pain).

test(balantidiasis, sigmoidoscopy_procedure).

locale(balantidiasis, all).

treatment(balantidiasis, tetracyclines).
treatment(balantidiasis, metronidazole).
treatment(balantidiasis, iodoquinol).



%Chromoblastomycosis
disease(chromoblastomycosis).

symptom(chromoblastomycosis, dull_red_demarcated_patches).
symptom(chromoblastomycosis, lesions).
symptom(chromoblastomycosis, lymphatic_drainage).
symptom(chromoblastomycosis, obstructed_lymphatics).
symptom(chromoblastomycosis, itching).
symptom(chromoblastomycosis, ulcerations).

test(chromoblastomycosis, add_potassium_hydroxide_to_lesion_sample).

locale(chromoblastomycosis, madagascar).
locale(chromoblastomycosis, japan).
locale(chromoblastomycosis, all).

treatment(chromoblastomycosis, itraconazole).
treatment(chromoblastomycosis, cryosurgery).



%Mycoplasma Pneumonia
disease(mycoplasma_pneumonia).

symptom(mycoplasma_pneumonia, tired).
symptom(mycoplasma_pneumonia, sore_throat).
symptom(mycoplasma_pneumonia, fever).
symptom(mycoplasma_pneumonia, cough).
symptom(mycoplasma_pneumonia, lung_infection).

test(mycoplasma_pneumonia, culture_test).
test(mycoplasma_pneumonia, serology_test).

locale(mycoplasma_pneumonia, all).

treatment(mycoplasma_pneumonia, macrolides).
treatment(mycoplasma_pneumonia, fluoroquinolones).
treatment(mycoplasma_pneumonia, tetracyclines).



%Typhus Fever
disease(typhus_fever).

symptom(typhus_fever, headache).
symptom(typhus_fever, fever).
symptom(typhus_fever, shivering).
symptom(typhus_fever, rash).
symptom(typhus_fever, confusion).
symptom(typhus_fever, low_bloods_pressure).
symptom(typhus_fever, muscle_ache).
symptom(typhus_fever, dry_cough).
symptom(typhus_fever, diarrhea).
symptom(typhus_fever, nausea).
symptom(typhus_fever, swollen_lymph_nodes).
symptom(typhus_fever, red_lesions).

test(typhus_fever, skin_biopsy).
test(typhus_fever, western_blot).
test(typhus_fever, immunofluorescence).
test(typhus_fever, blood_test).

locale(typhus_fever, asia).
locale(typhus_fever, pacific_islands).
locale(typhus_fever, australia).
locale(typhus_fever, all).

treatment(typhus_fever, doxycycline).
treatment(typhus_fever, chloramphenicol).
treatment(typhus_fever, ciprofloxacin).



%Tuberculosis
disease(tuberculosis).

symptom(tuberculosis, cough).
symptom(tuberculosis,chest_pain).
symptom(tuberculosis,coughing_up_blood).
symptom(tuberculosis,fatigue).
symptom(tuberculosis,weightLoss).
symptom(tuberculosis,no_appetite).
symptom(tuberculosis,shivering).
symptom(tuberculosis,fever).
symptom(tuberculosis,night_sweating).

test(tuberculosis,tb_test).
test(tuberculosis,tb_test).

locale(tuberculosis,all).

treatment(tuberculosis,isoniazid).
treatment(tuberculosis,rifampin).
treatment(tuberculosis,ethambutol).
treatment(tuberculosis,pyrazinamide).

 

%Smallpox
disease(smallpox).

symptom(smallpox,fever).
symptom(smallpox,ache).
symptom(smallpox,vomit).
symptom(smallpox,rash).
symptom(smallpox,scab).

locale(smallpox,none).

treatment(smallpox,smallpox_vaccine).

 

%Rubella
disease(rubella).

symptom(rubella,low_grade_fever).
symptom(rubella,headache).
symptom(rubella,pink_eye).
symptom(rubella,discomfort).
symptom(rubella,swollen_lymph_nodes).
symptom(rubella,cough).
symptom(rubella,runny_nose).

test(rubella,pcr).
test(rubella,molecular_typing).
test(rubella,serology_test).

locale(rubella,africa).
locale(rubella,middle_east).
locale(rubella,south_asia).
locale(rubella,southeast_asia).

treatment(rubella,mmr_vaccine). 



%AIDS
disease(aids).

symptom(aids, flu_like).
symptom(aids , swollen_lymph_nodes).
symptom(aids , fever).
symptom(aids , weight_loss).

test(aids , elisa_test).
test(aids , cd4).
test(aids  , viral_antigen_detection).

locale(aids,north_america).
locale(aids,south_america).
locale(aids,europe).
locale(aids,africa).
locale(aids,asia).
locale(aids,antartica).
locale(aids,australia).

treatment( aids , nnrti).
treatment( aids , nrti).
treatment(aids , protease_inhibitor).
treatment(aids , entry_inhibitor).
treatment(aids , fusion_inhibitor).
treatment(aids , integrase_inhibitor).




%Bubonic Plague
disease(bubonic_plague).

symptom(bubonic_plague, fever).
symptom(bubonic_plague, headache).
symptom(bubonic_plague , vomiting).
symptom(bubonic_plague, swollen_lymph_nodes).

test( bubonic_plague, yersinia_pestis).

locale(bubonic_plague,africa).
locale(bubonic_plague,asia).
locale(bubonic_plague,south_america).

treatment(bubonic_plague, gentamicin).
treatment(bubonic_plague, doxycycline).
treatment(bubonic_plague, ciprofloxacin).
treatment(bubonic_plague, levofloxacin).



