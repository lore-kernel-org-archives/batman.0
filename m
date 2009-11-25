Return-Path: <onelektra@gmx.net>
Message-ID: <4B0D43FF.7030306@gmx.net>
Date: Wed, 25 Nov 2009 15:49:35 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
References: <4B0D0DD2.1040107@rsm-freilassing.de>
	<4B0D106F.40404@lo-res.org>	<4B0D3815.9020104@gmx.net>
	<01287D91-E22C-4E56-A9ED-C8843EFF6773@lo-res.org>
In-Reply-To: <01287D91-E22C-4E56-A9ED-C8843EFF6773@lo-res.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Protocol quarrels
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>



> Don't be unfair... Hang on, I actually said, OLSR stuff belongs on the respective mailing list there.
> (and suggested to take a look at BGP)
>
>   
>> We have occasional OLSR advertisement fade-ins on this list - I guess the Babel/OLSR/Batman quarrel will become proverbial one day ;-)
>>     

Methinks <http://www.dict.cc/englisch-deutsch/Methinks.html> thou 
<http://www.dict.cc/englisch-deutsch/thou.html> dost 
<http://www.dict.cc/englisch-deutsch/dost.html> protest 
<http://www.dict.cc/englisch-deutsch/protest.html> too 
<http://www.dict.cc/englisch-deutsch/too.html> much. 
<http://www.dict.cc/englisch-deutsch/much..html>

Read your own writing on the OLSR-users list below.

Cheers,
Elektra


[Olsr-users] Current OLSR protocol
L. Aaron Kaplan aaron at lo-res.org
 Fri May 22 14:29:52 UTC 2009
Previous message: [Olsr-users] Current OLSR protocol
Next message: [Olsr-users] Current OLSR protocol
Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
On May 22, 2009, at 3:46 PM, Damian Philipp wrote:

 > Hello,
 >
 > I'm currently gathering some information about available routing 
 > protocols for mesh networks for my diploma thesis. So far, I have 
 > found rather confusing things about OLSR. From 
http://www.olsr.org/?q=background
 >  I gathered that most of the optimizations to get olsr working were 
 > code improvements. However, 
https://www.open-mesh.org/wiki/the-olsr-story
 >  paints a somewhat different picture with inherent instabilities in 
 > the original concept of olsr which is why they started over with 
 > BATMAN.


Well... Let me give you my personal opinion on that.
Mainly Elektra from BATMAN was very often behind a FUD strategy 
against OLSR.
Which is weird but it is like that. Maybe it is in order to start the 
new project BATMAN.
 From the OLSR.org side, this is great that there is a new attempt at 
routing protocols since we can all learn from that and from the new 
problems that a new routing protocol will give in practice.

However, I would *not* take the-olsr-story on open-mesh.org as 
correct, final, authoritative nor complete.
Fact is that mesh research is an ongoing process and we can all simply 
learn.

 >
 > From what I've read on the freifunk homepage, olsr is still widely 
 > in use on freifunk networks.
it is.

 > I'm guessing that they are probably using the latest stable olsrd 
 > from olsr.org. However what I have not been able to find out is what 
 > protocol the current implementation from olsr.org is using. Is it 
 > still RCF-3626 compliant or does it rather contain all the 
 > optimizations from the C-Base people, thus breaking RFC compliance?
 >
it is RFC compliant but we all turn on extensions to RFC3626 in 
practice (ETX, Fisheye, ...) which break compatibility. But these are 
flags. You can turn them off.

 > As part of my thesis I will have to experiment with some extensions 
 > to the OLSR protocol. In order to be able to design those, I'd like 
 > to know the protocol I'm actually using ;-)
 >
  I suggest that you start to familiarize yourself with the basic 
datastructures, the RFC and maybe the plugin API. You will find more 
help concerning these issues on olsr-dev at lists.olsr.org.

 > I did find the OLSRv2-Draft at 
http://www.ietf.org/internet-drafts/draft-ietf-manet-olsrv2-08.txt
 > . This however still contains Multipoint relays, which as mentioned 
 > on open-mesh.org seem to be (have been?) one of the bigger issues -- 
 > thus my confusion.

no, ... open-mesh.org is a lot of personal opinion by Elektra.
So, again... take that with a grain of salt please ;-)

There was even once a paper published by Elektra and some insitute in 
South Africa which again "proves" that OLSR does not scale and stuff 
like that.

In the history of routing protocols you can always find this trend 
that some proposals were made, some succeeded in acceptance (i.e. they 
were made an RFC) and then a *great* deal* of work was still needed to 
actually make it scalable and secure in practice.

Take BGP for example: we (== the internet) is still fighting with some 
basic security problems of BGP [1]. So even the development of BGP is 
still ongoing.

Summary: it is the implementation which counts!
And OLSR.org put *a lot* of effort into that the last 2 years.

So the basic real dichotomy between OLSR.org and BATMAN is actually 
the question:
  "do something new or improve the old stuff?"
I guess both are valid positions somehow.


[1] http://www.wired.com/threatlevel/2008/08/revealed-the-in/




Previous message: [Olsr-users] Current OLSR protocol
Next message: [Olsr-users] Current OLSR protocol
Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
More information about the Olsr-users mailing list

[Olsr-users] Current OLSR protocol
L. Aaron Kaplan aaron at lo-res.org
 Fri May 22 15:51:00 UTC 2009
Previous message: [Olsr-users] Current OLSR protocol
Next message: [Olsr-users] Current OLSR protocol
Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
Ulf, I do not agree with your assessment. The result of the FUD can be 
clearly seen by the uncertainty and doubt that people have been having 
repeatedly on this mailing list.
So therefore I believe I can rest my case and the mail by Damian was 
the proof for my FUD theory.

I also believe that I am actually quite fair. And I really do admire 
the work of Axel and others! No doubt about that!

:)

 >
 >
 > ps. it would be better to join to the wireless community weekend, to
 > work together on the olsr issues then writing such a crap!
 >

I am currently at work and could not come. Simple as that.

Besides, I do reserve the right to have my own experience and my 
opinion and do not tolerate others just calling my impression crap 
when they have no idea of *how* often I had to "defend" against the oh-
my-god-they-are-continuing-on-olsr.org-while-we-self-perceived-
semigods-in-berlin-are-already-working-on-batman-which-is-bettter-and-
therefore-the-rest-of-the-world-is-wrong-and-sucks attitude of some 
folks in Berlin. It is really tiresome to always have to "defend" a 
decision to still work on olsr.org in face of public *propaganda*.

I see it like that: there is room for improvement on olsr.org and 
there is a place for BATMAN.
Different goals. That is all. But why oh why do all the people get 
confused when they read Elektra's text on open-mesh.org ? Why do I see 
the same and the same type of questions again and again?
Exactly because it is propaganda.

ok, over and out. I think I made my point clear.
<joke>if you want we can carry this out in person with boxing gloves</
joke> ;-))


PS: again, in case it was not clear enough - congrats to successes of 
BATMAN . It is *not* the issue of which is better. It is an issue if 
Elektra pisses on other people constantly or not.
But I guess I should get simply used to that... seems like she likes 
it. *sigh*

whatever,
a.

 
