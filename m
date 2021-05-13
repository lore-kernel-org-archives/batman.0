Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v3 0/4] batctl: Add JSON debug commands
Date: Thu, 13 May 2021 16:28:08 +0200
Message-Id: <20210513142812.1707215-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>

Following JSON debug commands will be added: originators_json,
neighbors_json, translocal_json, transglobal_json.

This patches reffering to following patches:

[1] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/SAQYUZQ7I7H7VWHFPVLBUDYCFX7HNWLO/
[2] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/IV2OFJ2KJX52K4ARZ5MIWZ2A42WOKJRO/
[3] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/EYQBFU5O7E3KKRG2YVPLRGHHN3OFIPYP/
[4] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/WKIBP64G27O23MBAPHECSKNJMUESWFAG/
[5] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/Y3XXIYCJWME4CQNWRBIRYJ6ZOL4MI2FT/
[6] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/LYMU5ZA3I6YVHHRZVY3RJJR4KDHF76QI/
[7] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/STECUTMMJGHBJSEHLMDWFOA4VDDDTACS/
[8] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/W6XWJURD5G577ZPK6WO4XTNTKX5C65Y3/

Alexander Sarmanow (4):
  batctl: originators_json: Add originators_json command
  batctl: neighbors_json: Add neighbors_json command
  batctl: transglobal_json: Add transglobal_json command
  batctl: translocal_json: Add translocal_json command

 Makefile           |  4 +++
 README.rst         | 60 +++++++++++++++++++++++++++++++++
 man/batctl.8       | 12 +++++++
 neighbors_json.c   | 82 ++++++++++++++++++++++++++++++++++++++++++++
 originators_json.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 transglobal_json.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 translocal_json.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 404 insertions(+)
 create mode 100644 neighbors_json.c
 create mode 100644 originators_json.c
 create mode 100644 transglobal_json.c
 create mode 100644 translocal_json.c

-- 
2.25.1

