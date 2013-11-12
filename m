Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 12 Nov 2013 20:51:30 +0100
References: <525B189E.1080105@altermundi.net>
 <201310141952.34222.sw@simonwunderlich.de> <5282816E.9070109@altermundi.net>
In-Reply-To: <5282816E.9070109@altermundi.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201311122051.30677.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] alfred: optionally bundle a lua script
	for generating a bat-hosts
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Gui Iribarren <gui@altermundi.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org


> Provide a lua script that uses alfred to propagate and collect all
> interface mac + names, then generate a /tmp/bat-hosts file.
> If there's already a (probably hand-made) /etc/bat-hosts it won't overwrite
> it, but if there's none, it will symlink /etc/bat-hosts -> /tmp/bat-hosts
> 
> Signed-off-by: Gui Iribarren <gui@altermundi.net>
> Thanks-to: Joshua Head <joshua.head@outlook.com>

Applied to both our alfred development feed (c35db90) and OpenWRT routing feed 
(fc93a9c).

Thanks,
    Simon

