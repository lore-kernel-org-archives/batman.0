Return-Path: <hexiled@nixbits.net>
Message-ID: <50776C62.4040406@nixbits.net>
Date: Thu, 11 Oct 2012 21:03:30 -0400
From: HeXiLeD <hexiled@nixbits.net>
MIME-Version: 1.0
References: <CAMVTf1hohrQTfKbhD+SfhgX4xvdBZPvTATw+gLPjdek3VOU_zQ@mail.gmail.com>
In-Reply-To: <CAMVTf1hohrQTfKbhD+SfhgX4xvdBZPvTATw+gLPjdek3VOU_zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] How to create a Firmware o Image with a specific
 batman-adv configuration
Reply-To: HeXileD@nixbits.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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

That is very much all about openwrt and the wiki provides all the
information.
When you build the image just ad your configuration files to
"backfire/package/base-files/files/etc/config/

Then build the image and that is it.


On 10/11/2012 08:00 PM, Esteban Municio wrote:
> Hi list
> 
> I would like to create/compile a OpenWRT image with a specific
> batman-adv configuration previously loaded.
> I mean that the final user don't need to edit the configuration
> files(dhcp, bridges, wireless etc...), like /etc/rc.local or
> /etc/config/network , only flash the device with the image to use it.
> 
> Maybe it would be more suitable to ask it in a OpenWRT forum/list, but
> if anyone know something about it, I would be thankful
> 
> Regards
> 
