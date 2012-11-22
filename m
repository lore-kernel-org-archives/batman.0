Return-Path: <emunicio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1587719.gZG6lsm63o@bentobox>
References: <CAMVTf1ieWEkLOjcK0w2prCvFRmR4W+BYMett7ySrTQP1Yt2m_Q@mail.gmail.com>
 <1587719.gZG6lsm63o@bentobox>
From: Esteban Municio <emunicio@gmail.com>
Date: Thu, 22 Nov 2012 16:10:52 -0500
Message-ID: <CAMVTf1jTfdwLzOm9_n97VVO4t8fMxyCX_w0tbv-i6euMUAy71A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Compile batman-adv code
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

I'm not understanding well your advices...

>> What should we do for try our own changes in the code of batman-adv?
>
> You should just clean the batman-adv part of openwrt after each change instead
> of compiling everything again. You can for example modify the prepare part of
> the Makefile script of the batman-adv openwrt package to copy the
> .c/.h/.sh/Makefile* from your development folder. At least Martin did this (or
> at least something similar).

Do you mean that I should modify the makefile (my path to this
makefile is .../backfire/trunk/feeds/packages/net/batman-adv/Makefile)so
instead the download the code of batman-adv, it compile my own code?

> A simple `make package/batman-adv/{clean,prepare,compile,install}` after each test
> change would be enough to just get the new code, recompile the batman-adv
> module and to generate a ipk package for batman-adv. This ipk file can be
> copied to your testnode and installed using `opkg instal *.ipk`. The new
> module will be loaded after a restart.
>
> But an initial compile of the OpenWRT target kernel is still necessary.
>
> Btw. you can get write access to the batman git repositories when you like to.
>

But, how can I compile only the batman module and generate ipk package?
If I compile directly the batman-adv code, the batman-adv.ko module
does not work in the testnode.
Can I generate a batman-adv ipk package with out compile the whole openwrt?

Sorry for my thickness ;-)
-- 
Esteban
