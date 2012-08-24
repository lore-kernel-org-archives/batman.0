Return-Path: <dominicfollett@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6567295.mkEhlW2YzJ@bentobox>
References: <CA+h5Vgrcu=R7odK4av7cVs9Ov7+ZSXf0SgPM7riJ2HRpyYUvHA@mail.gmail.com>
 <6567295.mkEhlW2YzJ@bentobox>
Date: Fri, 24 Aug 2012 14:01:15 +0200
Message-ID: <CA+h5VgoW-uajF0dHti6eePGFOkcdzkesyEWRR2L6gNhkOG=2Og@mail.gmail.com>
From: Dominic Follett-Smith <dominicfollett@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] editing the routing information
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

Hi Sven, thank you,

I will have a closer look at the code and send some more details over
the weekend. Essentially I understand that neighbor ranking for a
destination node 'D'  is performed on the number of OGM's received in
the sliding window. What I want to do is introduce an extra metric say
X that alters the number of OGM's in the sliding window (a kind of
penalty), then when BATMAN calculates the next best hop for that
destination 'D', this information will reflect that:

For example,  N1: node that wishes to route a packet to destination D
                     D: Destination node
                     N2, N3: Neighbours of N1 and D

[1] at t = 0:
        (N2)
       /      \___
      /              \
(N1)                (D)
     \         ____/
      \       /
       (N3)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[2] at t = t_1: N2 and N3 broadcast their OGM's with some metric about
themselves (X_n) attached. N(1) keeps a list of neighbours, with their
associated metric X_n at any time- it will be used for neighbour
ranking.

               (N2)
 ogm+x_2/      \___
             /              \
       (N1)                (D)
            \         ____/
ogm+x_3\       /
               (N3)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[3] at t = t_2: D Broadcasts its OGM

        (N2)
       /      \_OGM
      /              \
(N1)                (D)
     \      OGM_/
      \       /
       (N3)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[4] at t = t_3: N2 forward D's OGM onto N1

        (N2)
OGM/      \___
      /              \
(N1)                (D)
     \         ____/
      \       /
       (N3)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[5] at t = t_4:

sliding window of neigbour N2 for Destination D is:

|__________10....._|    --> ten sequence numbers have been received
from D over N2 but we penalize this count with x_2, which leaves it at
6

sliding window of neigbour N3 for Destination D is:

|__________8....._|    --> eight sequence numbers have been received
from D over N3 but we penalize this with x_3, which leaves it at 6

at this point the next best hop to route a packet to destination D is N2 or N3

and lastly in this time interval, N3 forward D's OGM onto N1

           (N2)
          /      \___
         /              \
      (N1)                (D)
OGM\         ____/
         \       /
          (N3)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 [6]  at t = t_5:

sliding window of neigbour N2 for Destination D is:

|__________10....._|    --> ten sequence numbers have been received
from D over N2 but we penalize this count with x_2, which leaves it at
6

sliding window of neigbour N3 for Destination D is:

|__________9....._|    --> nine sequence numbers have been received
from D over N3 but we penalize this with x_3, which leaves it at 7

at this point the next best hop to route a packet to destination D is
the link over N3
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Again, thank you for your kind assistance.

Dominic
UCT

On Tue, Aug 21, 2012 at 12:32 AM, Sven Eckelmann <sven@narfation.org> wrote:
>
> On Sunday 19 August 2012 17:13:28 Dominic Follett-Smith wrote:
> > I am using the batmand release and I trying to edit where batman keeps
> > a statistic of next best hops to a destination node.
>
> The development focus of many people changed to batman-adv. Therefore, most
> people aren't knowing the code very well (or have to read a while to get into
> the code again).
>
> > I want to change
> > the metric in some way to alter the choices that batman makes when
> > routing a packet to its destination. However I am rather stuck, and
> > would appreciate some direction on where the updating of this
> > statistic of next best hops for a destination is done in the batman
> > code.
>
> You're request is a little bit too general. Maybe you can go a little bit more
> in detail. Otherwise I can only recommend batman(void) in batman.c and
> update_orig(...) in originator.c
>
> Kind regards,
>         Sven
