Return-Path: <gtolon@inti.gob.ar>
Message-ID: <4EC66907.8040004@inti.gob.ar>
Date: Fri, 18 Nov 2011 11:17:43 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
References: <mailman.3.1321441202.24844.b.a.t.m.a.n@lists.open-mesh.org>
In-Reply-To: <mailman.3.1321441202.24844.b.a.t.m.a.n@lists.open-mesh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N Digest, Vol 59, Issue 21
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
To: b.a.t.m.a.n@lists.open-mesh.org

Thank you for the advice Marek! We've setted the mcast_rate in 18000 
using uci and it's quite better! Unfortunately we've found a problem 
apparently related with ath9k driver, so we couldn't go on with more 
complicated routes tests. Thanks!







> ------------------------------ Message: 4 Date: Wed, 16 Nov 2011 
> 11:30:05 +0800 From: Marek Lindner <lindner_marek@yahoo.de> To: "The 
> list for a Better Approach To Mobile Ad-hoc Networking" 
> <b.a.t.m.a.n@lists.open-mesh.org> Subject: Re: [B.A.T.M.A.N.] Problem 
> to find better Route Message-ID: 
> <201111161130.05500.lindner_marek@yahoo.de> Content-Type: Text/Plain; 
> charset="iso-8859-1" On Wednesday, November 16, 2011 01:59:11 
> gtolon@inti.gob.ar wrote:
>> >  Thank you for your answers. I copy the Originator's tables for the three
>> >  nodes:
>> >  
>> >  [..]
>> >
>> >  This is a typical state of the tables. We tryed setting the hop pennalty
>> >  parameter to 1, but the behaviour hasn't changed.
> The TQ values are quite close, so I can imagine that batman has a hard time
> finding the better path. You could try to set the broadcast rate to a fixed
> value (5.5 or even 18) to force the driver to not send the broadcasts at such
> a low rate.
>
> Cheers,
> Marek
>
>
> ------------------------------
>
> Message: 5
> Date: Wed, 16 Nov 2011 09:32:11 +0100
> From: Antonio Quartulli<ordex@autistici.org>
> To: The list for a Better Approach To Mobile Ad-hoc Networking
> 	<b.a.t.m.a.n@lists.open-mesh.org>
> Subject: Re: [B.A.T.M.A.N.] Problem to find better Route
> Message-ID:<20111116083210.GA17049@ritirata.org>
> Content-Type: text/plain; charset=utf-8
>
> On Wed, Nov 16, 2011 at 11:30:05 +0800, Marek Lindner wrote:
>> >  The TQ values are quite close, so I can imagine that batman has a hard time
>> >  finding the better path. You could try to set the broadcast rate to a fixed
>> >  value (5.5 or even 18) to force the driver to not send the broadcasts at such
>> >  a low rate.
> Can you really do that?
>
>
> Cheers,
>
> -- Antonio Quartulli ..each of us alone is worth nothing.. Ernesto 
> "Che" Guevara ------------------------------ Message: 6 Date: Wed, 16 
> Nov 2011 16:49:46 +0800 From: Marek Lindner <lindner_marek@yahoo.de> 
> To: "The list for a Better Approach To Mobile Ad-hoc Networking" 
> <b.a.t.m.a.n@lists.open-mesh.org> Subject: Re: [B.A.T.M.A.N.] Problem 
> to find better Route Message-ID: 
> <201111161649.46492.lindner_marek@yahoo.de> Content-Type: Text/Plain; 
> charset="utf-8" On Wednesday, November 16, 2011 16:32:11 Antonio 
> Quartulli wrote:
>> >  On Wed, Nov 16, 2011 at 11:30:05 +0800, Marek Lindner wrote:
>>> >  >  The TQ values are quite close, so I can imagine that batman has a hard
>>> >  >  time finding the better path. You could try to set the broadcast rate to
>>> >  >  a fixed value (5.5 or even 18) to force the driver to not send the
>>> >  >  broadcasts at such a low rate.
>> >  
>> >  Can you really do that?
> Yap. If you want to find out how: google is your friend.:-)
>
> Cheers,
> Marek
>
>
> ------------------------------
