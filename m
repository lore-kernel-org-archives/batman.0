Return-Path: <andrew@lunn.ch>
Date: Thu, 7 Apr 2016 01:58:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160406235808.GH19409@lunn.ch>
References: <CAAz6EDdLudcU10Uc2=u8_8zgvCuLMRoYHd3+kf77Q5_gzTkuVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAz6EDdLudcU10Uc2=u8_8zgvCuLMRoYHd3+kf77Q5_gzTkuVw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [B.A.T.M.A.N] simulate multihop
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

> Anyone have another solution or i am doing something wrong? I think
> that ebtables does not work because my interface (wireless) is not on
> bridge mode, i cannot set it for bridge mode because i need create a
> mesh network (the wireless interface have to be in ad hoc mode).

If you look on the list, there are patches to make BATMAN network
namespace aware. You can then put the instances in different
namespaces, and use veth's to connect them together in the topology
you want.

    Andrew
