Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 7 May 2013 16:03:22 +0800
References: <CAJy53=m47HpBE2vYsspJAVkyKR9OaV5gUTyxFvAzuEUo8FDpMg@mail.gmail.com>
 <5188AEE9.5040508@wirelesspt.net>
In-Reply-To: <5188AEE9.5040508@wirelesspt.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305071603.22556.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Have you considered compiled a batman-adv.ko for
	android?
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
To: b.a.t.m.a.n@lists.open-mesh.org, haijian sun <smartbaobao@gmail.com>

On Tuesday, May 07, 2013 15:36:09 cmsv wrote:
> > so, I know it is the imcompatibility of my phone's kernel version and
> > the compile tool's, which seems easy to solve. But, here is the
> > question, If I want to develope a software for a lot of users, I can't
> > get their kernel version and compile each batman-adv.ko for them, and
> > unfortunately, android has various different versions.
> >
> > How about let android compile its own batman-adv.ko? But I think it is
> > of great difficulity.

You are right that compiling a kernel module for different versions and 
kernels out there is an uphill battle. An application in userspace is better 
suited for this approach. Alternatively, you have to convince the manufacturer 
to build batman-adv by default - batman-adv is part of the stock Linux kernel 
after all.

Nonetheless, even if you manage to solve the software compilation, 
distribution and adhoc mode inavailability / wifi bugs with different drivers 
you still have biggest issue unaddressed: power consumption. Ad-hoc mode has 
no power save mode I know of which leads to a steady battery drain as soon as 
you turn on your wifi. You don't even need to turn meshing and you can watch 
your smartphone's battery die

Of course, driving into the desert to show how 2 smartphones can talk to each 
other over a mesh is quite catchy but totally impractical in today's life. 
Until power saving can be solved in an intelligent manner everything else is a 
pointless exercise.

And no, carrying a car battery in your hand bag to power your phone is not a 
practical solution either.  ;-)

Cheers,
Marek
