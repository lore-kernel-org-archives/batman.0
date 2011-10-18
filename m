Return-Path: <ordex@autistici.org>
Date: Tue, 18 Oct 2011 19:51:47 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111018175147.GB22006@ritirata.org>
References: <CAFevQmMBoHLeQOhvYv9bYWh0YS7WYXDyL=geH9EcsqqgVeBj+w@mail.gmail.com>
	<201110181810.41338.lindner_marek@yahoo.de>
	<CAFevQmNi+csqs5q-LQBMhpnZG9KS2Q0kZJYUgHd9jwrzZGbmjw@mail.gmail.com>
	<CAFevQmNqwZFg39=umwOKTWR6W729-OrcNUFa+a0_e6ks1t3NSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFevQmNqwZFg39=umwOKTWR6W729-OrcNUFa+a0_e6ks1t3NSQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Compile error on openwrt with new patch
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Filippo,

On Tue, Oct 18, 2011 at 07:36:27 +0200, Filippo Sallemi wrote:
> opps sorry
> 
> 1. make clean
> 2. make distclean
> 3. make -j 3
> 

it works here..

can I suggest you to run "make V=99" and write down what the log
says? In this way that we can better understand what it is going on.

Moreover..did you get the last version of that patch? In the ml sometimes you
can find several version of the same patch. Please ensure it is the last one
(version 2)

Cheers,

> 2011/10/18 Filippo Sallemi <tonyputi@gmail.com>:
> > No my patch folder was empty before update. Now the only way to
> > compile batman-adv is to revert to last version.
> >
> > N.B. Here the command executed after first time error
> >
> > 1. svn clean;
> > 2. svn distclean;
> > 3. make -j 3
> >
> > So I build a vergin openwrt with only batman-adv module but the error persist.
> >
> >
> > 2011/10/18 Marek Lindner <lindner_marek@yahoo.de>:
> >>
> >> Hi,
> >>
> >>> after an ./script/feeds update when i try to build openwrt I get an
> >>> error on batman-adv package:
> >>>
> >>> Applying
> >>> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet
> >>> .patch using plaintext:
> >>> patching file translation-table.c
> >>> Hunk #1 FAILED at 1054.
> >>> Hunk #2 succeeded at 632 with fuzz 2 (offset -448 lines).
> >>> 1 out of 2 hunks FAILED -- saving rejects to file translation-table.c.rej
> >>> Patch failed!  Please fix
> >>> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet.
> >>> patch!
> >>
> >> works for me. Do you have additional patches in your patches folder which are
> >> incompatible ?
> >>
> >> Regards,
> >> Marek
> >>
> >
> >
> >
> > --
> > Filippo Sallemi
> >
> 
> 
> 
> -- 
> Filippo Sallemi

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
