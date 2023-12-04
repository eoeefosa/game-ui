const questionsData = [
  {
    "id": 1,
    "question": "What was the first thing God made?",
    "options": ["Man", "Birds", "Light", "Seas"],
    "answer": "Light",
    "BR": "Genesis 1:3",
    "level": 1
  },
  {
    "id": 2,
    "question":
        "God created a firmament to separate the waters from the ______.",
    "options": ["Land", "Seas", "Birds", "Waters"],
    "answer": "Waters",
    "BR": "Genesis 1:6",
    "level": 1
  },
  {
    "id": 3,
    "question": "On what day of creation did God create the sun and moon?",
    "options": ["First day", "Second day", "Fourth day", "Sixth day"],
    "answer": "Fourth day",
    "BR": "Genesis 1:14-18",
    "level": 1
  },
  {
    "id": 4,
    "question": "God called forth the birds of the air from the ______.",
    "options": ["Waters", "Ground", "Sky", "Trees"],
    "answer": "Waters",
    "BR": "Genesis 1:20",
    "level": 1
  },
  {
    "id": 13,
    "question": "Who gave Eve her name?",
    "options": ["God", "Adam", "Cain", "Abel"],
    "answer": "Adam",
    "BR": "Genesis 3:20",
    "level": 2
  },
  {
    "id": 14,
    "question":
        "God sent man out of the garden to make sure he does not eat of the tree of _______",
    "options": ["Evil", "Love", "Good", "Life"],
    "answer": "Life",
    "BR": "Genesis 1:22-23",
    "level": 2
  },
  {
    "id": 15,
    "question":
        "After God sent man out of the garden, God placed ______ at the east of the garden",
    "options": [
      "Sword of fire",
      "Pillar of fire",
      "Pillar of cloud",
      "Pillar of salt"
    ],
    "answer": "Sword of fire",
    "BR": "Genesis 3:24",
    "level": 2
  },
  {
    "id": 16,
    "question": "Which of the children of Adam was a shepherd?",
    "options": ["Cain", "Abel", "Enosh", "Jared"],
    "answer": "Abel",
    "BR": "Genesis 4:2",
    "level": 2
  },
  {
    "id": 17,
    "question":
        "After God cursed Cain, he put a mark on him so that anyone who sees him will not ______ him.",
    "options": ["Love", "Forgive", "Hate", "Kill"],
    "answer": "Kill",
    "BR": "Genesis 4:15",
    "level": 3
  },
  {
    "id": 18,
    "question": "What was the name of the first son of Cain?",
    "options": ["Lamech", "Pharez", "Zara", "Enoch"],
    "answer": "Enoch",
    "BR": "Genesis 4:17",
    "level": 3
  },
  {
    "id": 19,
    "question": "Cain built a city and named it after _______",
    "options": ["Himself", "His father", "His son", "His wife"],
    "answer": "His son",
    "BR": "Genesis 4:17",
    "level": 3
  },
  {
    "id": 20,
    "question": "Who was the first person in the Bible to marry two wives?",
    "options": ["Cain", "Lamech", "Noah", "Jacob"],
    "answer": "Lamech",
    "BR": "Genesis 4:19",
    "level": 3
  },
  {
    "id": 21,
    "question": "Who was the first musician in the Bible?",
    "options": ["Jabal", "Jubal", "Lamech", "Noah"],
    "answer": "Jubal",
    "BR": "Genesis 4:21",
    "level": 4
  },
  {
    "id": 22,
    "question": "Who was the third son of Adam and Eve?",
    "options": ["Shemei", "Enosh", "Moses", "Seth"],
    "answer": "Seth",
    "BR": "Genesis 4:25",
    "level": 4
  },
  {
    "id": 23,
    "question": "How old was Adam when his third son, Seth was born?",
    "options": ["100 years", "130 years", "200 years", "150 years"],
    "answer": "130 years",
    "BR": "Genesis 5:3",
    "level": 4
  },
  {
    "id": 24,
    "question": "How old was Adam when he died?",
    "options": ["120 years", "200 years", "900 years", "930 years"],
    "answer": "930 years",
    "BR": "Genesis 5:5",
    "level": 4
  },
  {
    "id": 25,
    "question": "Who was the person that lived the longest in the Bible?",
    "options": ["Methuselah", "Noah", "Jared", "Enoch"],
    "answer": "Methuselah",
    "BR": "Genesis 5:27",
    "level": 5
  },
  {
    "id": 26,
    "question": "Who was the father of Noah?",
    "options": ["Canaan", "Enoch", "Lamech", "Abel"],
    "answer": "Lamech",
    "BR": "Genesis 5:28-29",
    "level": 5
  },
  {
    "id": 27,
    "question": "How old was Noah when he had children?",
    "options": ["200 years", "150 years", "600 years", "500 years"],
    "answer": "500 years",
    "BR": "Genesis 5:32",
    "level": 5
  },
  {
    "id": 28,
    "question": "How many children did Noah have?",
    "options": ["Three", "Six", "Five", "Four"],
    "answer": "Three",
    "BR": "Genesis 5:32",
    "level": 5
  },
  {
    "id": 29,
    "question": "What kind of wood did Noah use in building the ark?",
    "options": ["Olive", "Lebanon", "Gopher", "Willow"],
    "answer": "Gopher",
    "BR": "Genesis 6:14",
    "level": 6
  },
  {
    "id": 30,
    "question": "What was the length of Noah's ark?",
    "options": ["400 cubits", "200 cubits", "300 cubits", "150 cubits"],
    "answer": "300 cubits",
    "BR": "Genesis 6:15",
    "level": 6
  },
  {
    "id": 31,
    "question": "How old was Noah when the great flood began?",
    "options": ["600 years", "200 years", "260 years", "365 years"],
    "answer": "600 years",
    "BR": "Genesis 7:6",
    "level": 6
  },
  {
    "id": 32,
    "question": "How many people entered Noah's ark?",
    "options": ["5", "70", "60", "8"],
    "answer": "8",
    "BR": "Genesis 7:7",
    "level": 6
  },
  {
    "id": 33,
    "question": "For how long did it rain during the great flood?",
    "options": ["Forty days", "Thirty days", "Twenty days", "Six days"],
    "answer": "Forty days",
    "BR": "Genesis 7:12",
    "level": 7
  },
  {
    "id": 34,
    "question":
        "How long did it take before the waters dried from the face of the earth after the great flood?",
    "options": ["150 days", "300 days", "30 days", "50 days"],
    "answer": "150 days",
    "BR": "Genesis 8:3",
    "level": 7
  },
  {
    "id": 35,
    "question": "On what mountain did Noah's ark rest after the flood?",
    "options": ["Olivet", "Moriah", "Moreh", "Ararat"],
    "answer": "Ararat",
    "BR": "Genesis 8:4",
    "level": 7
  },
  {
    "id": 36,
    "question":
        "Which bird did Noah first send out of the ark after the flood?",
    "options": ["Eagle", "Vulture", "Raven", "Dove"],
    "answer": "Raven",
    "BR": "Genesis 8:7",
    "level": 7
  },
  {
    "id": 37,
    "question": "What bird did Noah send out of the ark the second time?",
    "options": ["Dove", "Raven", "Hawk", "Owl"],
    "answer": "Dove",
    "BR": "Genesis 8:8",
    "level": 8
  },
  {
    "id": 38,
    "question":
        "The last time Noah sent a bird out of the ark, it came back with _______ in its mouth.",
    "options": ["A stone", "An olive leaf", "Water", "Oil"],
    "answer": "An olive leaf",
    "BR": "Genesis 8:11",
    "level": 8
  },
  {
    "id": 39,
    "question":
        "What was the first thing Noah built after he came out of the Ark?",
    "options": ["An altar", "A house", "A barn", "A bridge"],
    "answer": "An altar",
    "BR": "Genesis 8:20",
    "level": 8
  },
  {
    "id": 40,
    "question": "Which of the sons of Noah had a son called Canaan?",
    "options": ["Shem", "Japhet", "Schechem", "Ham"],
    "answer": "Ham",
    "BR": "Genesis 9:18",
    "level": 8
  },
  {
    "id": 41,
    "question": "Which of the sons of Noah saw their father's nakedness?",
    "options": ["Shem", "Ham", "Japhet", "Molech"],
    "answer": "Ham",
    "BR": "Genesis 9:22",
    "level": 9
  },
  {
    "id": 42,
    "question": "How old was Noah when he died?",
    "options": ["800 years", "900 years", "930 years", "950 years"],
    "answer": "950 years",
    "BR": "Genesis 9:29",
    "level": 9
  },
  {
    "id": 43,
    "question": "In Genesis 10, who was called a mighty hunter?",
    "options": ["Cush", "Nimrod", "Tyre", "Cain"],
    "answer": "Nimrod",
    "BR": "Genesis 10:9",
    "level": 9
  },
  {
    "id": 44,
    "question": "The city of Nineveh was built by a man called _______",
    "options": ["Jonah", "Shem", "Japhet", "Asshur"],
    "answer": "Asshur",
    "BR": "Genesis 10:11",
    "level": 9
  },
  {
    "id": 45,
    "question": "Who was the first king of the city of Babel?",
    "options": ["Nimrod", "Cush", "Ishmael", "Cain"],
    "answer": "Nimrod",
    "BR": "Genesis 10:10",
    "level": 10
  },
  {
    "id": 46,
    "question": "The tower of Babel was built in the land of ________",
    "options": ["Nineveh", "Shinar", "Moreh", "Israel"],
    "answer": "Shinar",
    "BR": "Genesis 11:2",
    "level": 10
  },
  {
    "id": 47,
    "question": "Who was the father of Abraham?",
    "options": ["Terah", "Nahor", "Haran", "Ishmael"],
    "answer": "Terah",
    "BR": "Genesis 11:26",
    "level": 10
  },
  {
    "id": 48,
    "question": "How many brothers did Abraham have?",
    "options": ["Three", "Two", "Four", "Five"],
    "answer": "Two",
    "BR": "Genesis 11:27",
    "level": 10
  },
  {
    "id": 49,
    "question": "Who was the father of Lot?",
    "options": ["Abram", "Terah", "Nahor", "Haran"],
    "answer": "Haran",
    "BR": "Genesis 11:27",
    "level": 11
  },
  {
    "id": 50,
    "question": "How old was Terah when he died?",
    "options": ["300 years", "400 years", "205 years", "250 years"],
    "answer": "205 years",
    "BR": "Genesis 11:32",
    "level": 11
  },
];
