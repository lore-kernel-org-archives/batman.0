Return-Path: <ordex@autistici.org>
Date: Mon, 21 Nov 2011 20:27:24 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111121192611.GA32510@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] batman-adv stable patches: information request
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hello Greg,

I'm Antonio Quartulli, a net/batman-adv kernel module contributor, and I'm
contacting you as you are the stable tree maintainer.

On Oct 25, 2011 I sent the following two patches to stable@kernel.org:

- [PATCH 1/2] batman-adv: fix tt_local_reset_flags() function
  which is 31901264511cf20c5ed33b8649a3ca9ce28df60b in David's net-next branch


- [PATCH 2/2] batman-adv: correctly set the data field in the TT_REPONSE packet
  which is 9d8523931f7f5eb8900077f0da0fbe6b8ad0010b in David's net-next branch

Up to now we didn't received any reply, either ACK or NACK, but I saw that
linux-3.1.1 has been released in the meanwhile. As I guessed, this release
doesn't contain our patches.

Did I miss something in the stable-submit procedure?
I'm sorry for any inconvenient but this is the first time that I send patches to
stable.



Best Regards,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
