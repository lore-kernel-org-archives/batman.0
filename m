Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 7 May 2010 22:43:11 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201005072243.12054.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman patch authorship mangled
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Greg KH <greg@kroah.com>
Cc: b.a.t.m.a.n@lists.open-mesh.net, Luis de Bethencourt <luisbg@ubuntu.com>, Linus


Hi Greg,

the last patchset sent by Andrew contained a few errors regarding the 
authorship due to incorrect handling on our side. We did not notice these 
issues until the patches went out to get included by you.

Here is the complete list of incorrect assignments:
 * should be Linus instead of Simon
 => [PATCH 07/26] staging:batman-adv: Remove dead max addr and obsolete 
VIS_FORMAT strings
 => [PATCH 09/26] staging:batman-adv: Update README about vis raw output

 * should be Luis instead of Marek
 => [PATCH 12/26] staging:batman-adv: fix whitespace style issues

 * should be Sven instead of Marek
 => [PATCH 24/26] staging:batman-adv: Fix whitespace problems criticized by 
checkpatch.pl
 => [PATCH 25/26] staging:batman-adv: Reduce max characters on a line to 80

Is there any way to correct the authors of the patches in question ? I know 
that modifying the git history to fix the author will change all following 
hashes and everyone has to rebase its tree.
Personally, I'm not so worried about Linus & Sven, since they are longterm 
contributors and somewhat close to the project. I'm sure a beer or two can 
compensate them for the loss of fame. Luis on the other hand seemed to be 
quite thrilled about getting his patch in and I'd rather not leave him with 
the impression we don't want to credit him for his work.

Regards,
Marek
