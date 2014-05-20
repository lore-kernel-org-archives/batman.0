Return-Path: <andrew@lunn.ch>
Date: Tue, 20 May 2014 23:41:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140520214134.GB11248@lunn.ch>
References: <CAEbDFcQh8b8jmTNFGdwG0Me1vV7O-1G=r8F0Ki53=OwhhwgM5Q@mail.gmail.com>
 <20140520140157.GE9873@lunn.ch>
 <CAEbDFcRM68JXcZ=rq2-i05EL4yO8iv5kq3Bf6GaJQuH_LWQRVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbDFcRM68JXcZ=rq2-i05EL4yO8iv5kq3Bf6GaJQuH_LWQRVQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Adding security on BATMAN-ADV
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, May 21, 2014 at 12:59:29AM +0530, Krishnathiepan Rasanayagam wrote:
> hello,
> layer below does it mean layer 2?

Layer above and layer below does not always map to ISO OSI 7 layer
model. BATMAN is a layer two mesh, and it runs on top of a L2
network. See what i mean?

Are you interested in transitive trust, or end to end trust of BATMAN
peers? If transitive trust is sufficient, then you can do it at L2,
trust the one hop neighbors. However if you want end-to-end trust of
the mesh, you need to be inside the mesh, so inside BATMAN. If you
want end-to-end application trust, you need to be inside the
application, L7, or maybe L4 if you use TLS.

It comes down the basic security questions you should always be
considering:

What are your assets you need to protect.
Who are the attackers.
What compromises are you willing to take.

First figure out your security model, then figure out how to implement
it.

	Andrew

