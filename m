Return-Path: <andrew@lunn.ch>
Date: Mon, 7 Mar 2016 14:47:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160307134701.GA15541@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-4-git-send-email-andrew@lunn.ch>
 <20160307042148.GF3229@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20160307042148.GF3229@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Handle parent
 interfaces in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Mon, Mar 07, 2016 at 05:21:48AM +0100, Linus L=FCssing wrote:
> Hi Andrew,
>=20
> Thanks for looking into this!
>=20
> It seems some compat code might be missing, compiling against a
> 3.19 kernel fails for me (4.0 to 4.4 compiles fine):

Hi Linus

I didn't look at compat code at all. I mostly work on net-next/master,
and the last -rc series.

Sven started a thread about this, and i can take a closer look to
see if i can help.

    Andrew
