Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Nov 2017 22:02:27 +0100
Message-Id: <20171120210229.9069-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/2] batctl: Convert CHANGELOG/README to
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

This patchset is based on the "batctl: License cleanup" patchset.

Kind regards,
	Sven

Sven Eckelmann (2):
  batctl: Convert CHANGELOG to reStructuredText
  batctl: Convert README to reStructuredText

 CHANGELOG         |  56 -----
 CHANGELOG.license |   2 -
 CHANGELOG.rst     |  60 +++++
 README            | 614 -----------------------------------------------
 README.license    |   2 -
 README.rst        | 694 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 754 insertions(+), 674 deletions(-)
 delete mode 100644 CHANGELOG
 delete mode 100644 CHANGELOG.license
 create mode 100644 CHANGELOG.rst
 delete mode 100644 README
 delete mode 100644 README.license
 create mode 100644 README.rst

-- 
2.11.0

