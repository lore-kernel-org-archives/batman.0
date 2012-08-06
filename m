Return-Path: <davem@davemloft.net>
Date: Mon, 06 Aug 2012 13:28:28 -0700 (PDT)
Message-Id: <20120806.132828.2156362429420693678.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1344089606-9573-1-git-send-email-ordex@autistici.org>
References: <1344089606-9573-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH net] batman-adv: select an internet
 gateway if none was chosen
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  4 Aug 2012 16:13:26 +0200

> From: Marek Lindner <lindner_marek@yahoo.de>
> =

> This is a regression introduced by: 2265c141086474bbae55a5bb3afa1ebb7=
8ccaa7c
> =

> Reported-by: Nicol=E1s Ech=E1niz <nicoechaniz@codigosur.org>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> Acked-by: Antonio Quartulli <ordex@autistici.org>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Applied.

Please, when referencing commits in a log message, provide the commit
header text ("LIKE THIS").  Otherwise in trees where the SHA1 IDs are
different, it will ambiguous what commit you are referencing.
