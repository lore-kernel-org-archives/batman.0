Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 10 Jun 2014 12:34:43 +0200
References: <CAEbDFcSdKZ=KyZE+sBFbiSgp91neo8KQ13paMYfxU5vEdyx72g@mail.gmail.com>
In-Reply-To: <CAEbDFcSdKZ=KyZE+sBFbiSgp91neo8KQ13paMYfxU5vEdyx72g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201406101234.43612.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Update batman-adv
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

That doesn't need a guide ...

Download the version you want from our download page.

tar zxf batman-adv-<version>.tar.gz
cd batman-adv-<version>
make
sudo make install

done. :)

Alternatively (and more cleanly, since you use the package system), update 
your kernel which contains the version you want. A list of which kernel 
contains which version can also be found on our download page.

Cheers,
    Simon

> hi all,
> 
> how to update batman-module to batman-adv 2014 in Ubuntu 12.
> Is there any guides available?
