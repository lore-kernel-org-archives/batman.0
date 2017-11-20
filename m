Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Nov 2017 22:02:14 +0100
Message-Id: <20171120210217.8941-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/3] batman-adv: Convert CHANGELOG/README to
 reStructuredText
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I was talking today with Simon about the "License cleanup" changes. He
would prefer when the *.license files don't exist (when possible). Luckily,
I already wanted to convert these files (or at least the READMEs) to
reStructuredText and I've already shown in these patchsets how the
SPDX annotation should be done for the lrest files. So it was just
logically to immediately post the conversion to rst and integration
of this tag.

We've also discussed how the changelog should look like. It should be
simple and we only wanted to show the date (not the time) anymore.
And the actual changelog lists should be kept (mostly untouched - beside
some minor format fixes to make it reStructuredText compatible).

This patchset is based on the "batman-adv: License cleanup" patchset.

Kind regards,
	Sven

Sven Eckelmann (3):
  batman-adv: Add .rst to README symlink
  batman-adv: Convert CHANGELOG to reStructuredText
  batman-adv: Convert README to reStructuredText

 CHANGELOG               | 634 ---------------------------------------------
 CHANGELOG.license       |   2 -
 CHANGELOG.rst           | 666 ++++++++++++++++++++++++++++++++++++++++++++++++
 README.external         |  51 ----
 README.external.license |   2 -
 README.external.rst     |  59 +++++
 README => README.rst    |   0
 7 files changed, 725 insertions(+), 689 deletions(-)
 delete mode 100644 CHANGELOG
 delete mode 100644 CHANGELOG.license
 create mode 100644 CHANGELOG.rst
 delete mode 100644 README.external
 delete mode 100644 README.external.license
 create mode 100644 README.external.rst
 rename README => README.rst (100%)

-- 
2.11.0

