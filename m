Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  7 Jul 2011 01:28:42 +0200
Message-Id: <1309994925-10165-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1309879385-21224-1-git-send-email-ordex@autistici.org>
References: <1309879385-21224-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 0/3] Solve consistency issues in TT code
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Hello all,

this is the second version of the TT consistency fix patchset.

The beautification patches have been removed as they were probably introducing
a few new problems (thanks Sven for pointing me to the C99 documentation) while
the remaining 4 patches have been merged in a more logical way.

Here is a little overview:
- 1/3 solves a 'little' bug found today.
- 2/3 fixes the way local tables are handled
- 3/3 fixes the roaming phase in order to keep consistency

For more details, please read the commit messages.
Thanks you!

Regards,
	Antonio Quartulli

