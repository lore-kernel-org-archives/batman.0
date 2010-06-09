Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 9 Jun 2010 16:12:45 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201006091612.46925.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] release cycle
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
To: b.a.t.m.a.n@lists.open-mesh.net


Hi,

while sitting in Bracciano (at the WMBv3), enjoying the sun and the excellent 
wine we were thinking about our current release cycle. Since we began merging 
our code into the official linux tree we published a new version roughly every 3 
months to have a compatible batman-adv/batctl version for each linux release. 
For instance:
 * linux 2.6.33 => batman-adv/batctl 0.2.0
 * linux 2.6.34 => batman-adv/batctl 0.2.1
 * linux 2.6.35 => batman-adv/batctl 0.2.2 (to be released soon)

Due to various reasons these minor versions (0.2.1 & 0.2.2) contain much more 
than just bugfixes. Individual features & major changes have been backported 
from the trunk. This has the advantage of adding new features faster instead 
of holding them back for months but on the other hand might introduce new bugs 
at the same time. How to move forward from here ?

After a long and healthy discussion we came to the following proposal:
 * We keep the 3 months release cycle containing new features. All new
    features go into the trunk first and when ready can be staged for the
    upcoming release. This way, we won't have major releases anylonger but
    rather a constant flow of new stuff.
 * To reflect the new & changed nature of the release, the version numbering
    has to change a bit. The following releases (after 0.2.2) will look like
    this: 0.3, 0.4, etc. We thought about adopting the linux numbering scheme
    but it might lead to confusion as you can use a new batman with older
    kernels.
 * If we find a volunteer to take the job, we would be interested in having a 
   "stable" branch. The maintainer could pick any release of interest, fetch
    stability patches flying around and apply only those to the branch. 

Comments ? If nobody objects we would start pretty soon following these 
guidelines.

Regards,
Marek
