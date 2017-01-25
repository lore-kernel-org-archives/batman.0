Return-Path: <andrew@lunn.ch>
Date: Wed, 25 Jan 2017 04:02:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20170125030222.GA25360@lunn.ch>
References: <98a77a75-ac8e-455a-6060-343b9020cd27@viisauksena.de>
 <2809895.eiDvevZ9tY@bentobox>
 <946ed248-8900-a0e2-4f35-ff288b04e360@viisauksena.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <946ed248-8900-a0e2-4f35-ff288b04e360@viisauksena.de>
Subject: Re: [B.A.T.M.A.N.] limit of if per batman
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

On Wed, Jan 25, 2017 at 03:21:58AM +0100, jens wrote:
> On 24.01.2017 14:39, Sven Eckelmann wrote:
> > There is no artificial limit added by batman-adv. But transmitting a lot of
> > broadcasts over 255 virtual links sharing the same physical link
> > might get interesting (independent of batman-adv).
> 
> this made me curious , and i modified your script a bit - turns out
> after the 127. IF you add to batman-adv you get an Error -
> all 510 gretap links was succesfully build ...
> # ifconfig |grep gre| wc -l
> 515
> # batctl if|sort|wc -l
> 127
> the error is mainly
> *Error - can't write to file
> '/sys/class/net/gre128/batman_adv/mesh_iface': Cannot allocate memory

Hi Jens

What sort of machine are you running this on? How much RAM does it
have?

My guess is, you are running it on a little box with not much RAM.  If
you tried again on your desktop with a few Giga byte of RAM, you will
get a different limit.

    Andrew
