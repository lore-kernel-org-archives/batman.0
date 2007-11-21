From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batman 0.3 and batmand-exp-0.3
Date: Wed, 21 Nov 2007 21:00:05 +0100
References: <470056.58415.qm@web26904.mail.ukl.yahoo.com>
	<200711201733.36966.lindner_marek@yahoo.de>
	<000601c82c52$1df6c0b0$59e44210$@com>
In-Reply-To: <000601c82c52$1df6c0b0$59e44210$@com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711212100.05898.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: pele@balorda.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello,

sounds like you made some good experience with the batman-exp branch. Thats 
really cheering to hear. Just, let me add some words regarding your 
understanding of the different branches.

batman-exp has started as a branch to make batman more configurable - e.g give 
the user more control about the system integration and even twist the core 
routing algorithm.  
Of course more flexibility also tends to make things more complex.
The majority of the developers did not wanted to have the bunch of optional  
configuration options in the standard batman branch, thats why these features 
were realized in a different branch. 

Particularly its possibility to experiment with the core routing metrics has 
lead to the extension "-experimental". Unfortunately, this has caused some 
people to think that the maturity of batman-exp is less advanced than the 
standard branch. This is NOT the idea, nor is it the other way around. Just 
two different branches, supposed to coexist and enrich each other.

Of course such a biased opinion tends to hurt a bit, and for the release I am 
already considering to rename it to something like -x or -exp. So it may 
considered as batman experimental, expert, extremely professional, or what so 
ever. But anyway, its just a name.


Approximately since the release of batman-0.3-alpha we have started to develop 
some new mechanisms to make the core routing algorithm more aware of 
asymmetric links and other stuff. And we had two different ideas to achieve 
this. It turned out, that one approach was implemented in the standard branch 
and the other one in the exp branch. 

I think that both approaches definitively have their charm and their 
shortcomings. And it requires the feedback of the users to further trigger 
the evolution of these approaches. I am very grateful for that and any other 
feedback, criticism, bug report, etc.

Regarding the versioning (0.3/0.4/apha/beta/rc1...). exp 0.3-alpha might be a 
bit conservative. However, there is a very small list of other features on my 
todo list which i would like to add before the code is freezed.

thanks,
axel


On Mittwoch 21 November 2007, Predrag Balorda wrote:
> I have been using the exp branch for over 2 weeks now and it is working
> nicely. OK my set-up is not huge, only 4 batman-enabled nodes with
> additional 6 repeaters as clients to batman nodes. Now I would like to know
> when will someone decide to kill off the 0.3 beta and continue with exp 0.3
> as the only batman? Maybe it's time to name it batman 0.4 and get rid of
> the "experimental" designation altogether (you even got the official
> ports)?
>
> I even believe exp can be now released as another stable version.
>
> Best regards to everyone on the list,
>
> Pele
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


