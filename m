Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/9] batctl: manpage spring cleaning
Date: Sat, 17 Jul 2021 13:01:20 +0200
Message-Id: <20210717110129.25539-1-sven@narfation.org>
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

Hi,

I went through the manpage and tried to clean up the structure of the manpage.
This should make it easier for add new entries to the manpage when subcommands
are added. But also to have a slightly better impression when trying to look
something up in the manpage.

As said, this is mostly about the the structure and not about the texts. So
if anyone wants to improve them too: feel free to submit patches.

Kind regards,
	Sven

Sven Eckelmann (9):
  batctl: man: Fix alignment after json list
  batctl: man: Move commands to own section
  batctl: man: Convert lists to indented paragraph
  batctl: man: Use native list support
  batctl: man: Use tbl groff preprocessor for tables
  batctl: man: Switch to manpage font convention
  batctl: man: Add example section
  batctl: man: Reorder and restructure sections
  batctl: man: Rewrite SEE ALSO list

 man/batctl.8 | 619 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 337 insertions(+), 282 deletions(-)

-- 
2.30.2

