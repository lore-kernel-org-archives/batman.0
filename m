Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Mar 2013 18:09:04 +0800
References: <1363293021-20505-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1363293021-20505-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201303161809.04428.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: Fix endianness errors
	for network coding
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

On Friday, March 15, 2013 04:30:21 Martin Hundeb=C3=B8ll wrote:
> Add a htonl() in network_coding.c when reading the sequence number
> from received ogm_packet, to avoid wrong byte ordering when comparing
> with a host value. This bug was introduced in
> 3ed7ada3f0bbcd058567bc0a8f9729a73eba7db6 ("batman-adv: network coding -
> detect coding nodes and remove these after timeout").
>=20
> Change the type of coded_packet->coded_len from uint16 to __be16 to
> avoid wrong assumptions about endianness in later uses. Introduced in
> c3289f3650d34b60296000a629c99f2488f7c3dd ("batman-adv: network coding -
> code and transmit packets if possible").
>=20
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>  network-coding.c | 2 +-
>  packet.h         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied in revision a67d520.

Thanks,
Marek
