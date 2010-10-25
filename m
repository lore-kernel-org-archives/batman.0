Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue, 26 Oct 2010 00:06:13 +0200
Message-Id: <1288044374-11771-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <AANLkTi=MbTkJiD-=7LcWdzMdqcJeqaBkX2G6O3oeUDZ8@mail.gmail.com>
References: <AANLkTi=MbTkJiD-=7LcWdzMdqcJeqaBkX2G6O3oeUDZ8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] batman-adv multi-hop route
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

Hi xianghua,

for such test cases basically this patch had once been made to force batman-adv
onto certain routes but needed to be removed again as the way ebtables is
used here is not standard-conforming. However, this shouldn't bother you :).

You can then just use ebtables to prohibit certain routes:
> ebtables -I INPUT -s MAC -j DROP or
> ebtables -I INPUT -p 0x4305 -j DROP
> (and the same for -I OUTPUT)

Antonio had been doing tests with this ebtables patch, too (see this
mailing list's archive from about the 10 May 2010).

This is a revert of the revert of commit 660d20261343e0b2ff57e51e50d7eb0e557d5e5b.
and applies on top of the current git master branch. If you need it for any
other version of batman-adv, try 'git revert 660d20261343e0b2ff57e51e50d7eb0e557d5e5b'
and if that doesn't work, just bug me again :).

Cheers, Linus
