Return-Path: <joe@perches.com>
Message-ID: <1467393566.21157.10.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Fri, 01 Jul 2016 10:19:26 -0700
In-Reply-To: <1467378549-9646-3-git-send-email-sw@simonwunderlich.de>
References: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
 <1467378549-9646-3-git-send-email-sw@simonwunderlich.de>
Content-Type: text/plain; charset="iso-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH 02/17] batman-adv: statically print
	gateway table header
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

On Fri, 2016-07-01 at 15:08 +0200, Simon Wunderlich wrote:
> To make it easier to search through the code it is better to print static
> strings directly instead of using format strings printing constants.

It's also generally smaller object code and faster at runtime.

$ size net/batman-adv/gateway_client.o*
=A0=A0=A0text	=A0=A0=A0data	=A0=A0=A0=A0bss	=A0=A0=A0=A0dec	=A0=A0=A0=A0hex=
	filename
=A0=A0=A04898	=A0=A0=A0=A0=A0=A01	=A0=A0=A0=A0=A0=A00	=A0=A0=A04899	=A0=A0=
=A01323	net/batman-adv/gateway_client.o.new
=A0=A0=A04951	=A0=A0=A0=A0=A0=A01	=A0=A0=A0=A0=A0=A00	=A0=A0=A04952	=A0=A0=
=A01358	net/batman-adv/gateway_client.o.old
