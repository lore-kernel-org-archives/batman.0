Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 4 Jun 2013 17:31:35 +0800
References: <1369722202-19422-1-git-send-email-martin@hundeboll.net>
 <51A450B4.9090901@hundeboll.net>
In-Reply-To: <51A450B4.9090901@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201306041731.35269.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix possible memleak in
	fragmentation
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Martin =?utf-8?q?Hundeb=C3=B8ll?= <martin@hundeboll.net>

On Tuesday, May 28, 2013 14:37:40 Martin Hundeb=C3=B8ll wrote:
> On 2013-05-28 08:23, Martin Hundeb=C3=B8ll wrote:
> > Use a variable for return value in batadv_frag_insert_packet() to free
> > the allocated struct batadv_frag_list_entry in all cases where it is not
> > inserted into a chain.
>=20
> The possible memleak was introduced by=20
> 9b3eab61754d74a93c9840c296013fe3b4a1b606 ("batman-adv: Receive=20
> fragmented packets and merge")

Applied in revision 0b415bb.

Thanks,
Marek
