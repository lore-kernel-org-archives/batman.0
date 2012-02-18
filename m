Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 18 Feb 2012 17:38:46 +0100
Message-Id: <1329583133-11681-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 0/7] batman-adv: Distributed ARP Table
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello people,

again, this code is related to the GSOC2011 project: DAT: Distributed ARP Table
for B.A.T.M.A.N.-Advanced. For more details, please have a look at the related
wikipage[1]. A more detailed, formal and technical wikipage will be written
soon.

****
This is the **sixth** version of this patchset. The whole code has been
reviewed
after some discussions on irc and here in the ml in the previous threads.
Several bugs have been spotted and fixed. Thanks Marek, Sven, Simon, Andrew
and
all the others for the comments/feedbacks.

Major changes regards the UNICAST_4ADDR patch which has been moved at the
beginning of the patchset, so that the rest of the code is directly based
onto
it. The same patch has also been hardly modified in order to become cleaner and
reuse the already available code as much as possible, thus reducing the
replicated one.

* v6 Additions:
- handling code for UNICAST_4ADDR has been deeply modified
- README.external has been updated with the new compile option.
- initialisation code for dat has been enclosed into two functions in order to
  avoid having #ifdefs around for the batman-adv code
- some minor fixes
- debugging output improved
****

[1] http://www.open-mesh.org/wiki/batman-adv/GSOC2011_DAT

