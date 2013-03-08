Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP5XTDNVPDVD_CXUScqc2D8D4+Xh7NFn=4YM6c8aBmjF7Lbi8A@mail.gmail.com>
References: <CAP5XTDP_8pCJA8uXpQoMNExiVaCvmBCmkKT_aDErk0qYk7-pmw@mail.gmail.com>
 <20130301110809.GC20607@ritirata.org>
 <CAP5XTDMV9dQucnRpe-fHvKUt-E3RKzEPQcNruG--fA8BnCv7UQ@mail.gmail.com>
 <20130301114300.GE20607@ritirata.org>
 <CAP5XTDNVPDVD_CXUScqc2D8D4+Xh7NFn=4YM6c8aBmjF7Lbi8A@mail.gmail.com>
Date: Fri, 8 Mar 2013 11:22:37 +0200
Message-ID: <CAP5XTDNdnZ_-BYJ+1ZtXdoBbh1kD0yD+=Cibs3GG4-yyZbSRzg@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Implement DAT for IPv6
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

Hi,

I have created a patch for this, just that is quite big (~ 450 lines
the whole patch, with signature, etc). It doesn't contain complex
changes, just small changes from __be32 to (unsigned char *), a new
parameter to functions in order to give the IP type and added
comments.

I've tested it with the snooping mechanism I added for IPv6 and it
works ok (the snooping mechanism is not in this patch).

What I wanted to ask is: it's ok to send a patch this big to the mailing list?
I don't see how I could split it more because all I did is changed
most of functions signatures and edit the code to support this
changes.

Thx,
Mihail
