Return-Path: <lambertarthur22@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120704092052.GB10142@pandem0nium>
References: <CAGpqJgoJ2V5TNcr5j+c=y88Vj4ipE0ke=y9ZDKqOvsaci+u54A@mail.gmail.com>
	<20120704092052.GB10142@pandem0nium>
From: Arthur Lambert <lambertarthur22@gmail.com>
Date: Wed, 4 Jul 2012 12:00:09 +0200
Message-ID: <CAGpqJgoZz+m9d41L2rVtOUzenzue_BjCt+YQ8h_TSEi7QbxwoQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [B.A.T.M.A.N] OGM problem and documentation
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

Hello,

thanks for your answer,

This is what I thought.. Its probably a mistake in my script to
measure signaling. I will check that.
I have already read the document that you give to me. This document
discribes most of the features
of Batman and some interesting stuffs. But I am looking for
information about global architecture, how
the protocol handles threads. An example of usefull draw  :
http://imgur.com/3ecCY. Its not always easy
to study or understand a complex project like Batman when you does not
know how a ad-hoc protocol works.

I am trying for example to follow the execution of the module with
tools like LTTNG to see how works
the implementation of workqueue or using GCOV to follow the data path.

And I interconnect my vm with special way. Its a king of bridge but
the tool that
I use simulate network topology so it more complicated than that.

I will come back problably later to ask questions, but at this moment,
I have to many questions,
I need first to continue reading the code and twiki, running my tests,
... again and again.

Arthur.

2012/7/4 Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>:
> Hello Arthur,
>
> On Tue, Jul 03, 2012 at 10:57:28AM +0200, Arthur Lambert wrote:
>> Hi,
>>
>> I am testing Batman Advance (Batman release 2012 1.0) and I am trying
>> to measure signaling on some topology of VMs. I have 81 nodes (Debian,
>> 3.0.9) with KVM virtualization. My topology is something like this :
>> http://imgur.com/Xh1gM
>>
>>
>> I have a topology with an adjacency matrix of maximum 4 as you can see
>> on my screenshot. I record on each VM signaling received and sent. On
>> some VM, my node send OGM at each "orig_interval" but does not receive
>> any OGM at all.
>>
>> Is it normal ?
>
> Well, no. :) Have you checked that the problem is really with batman and
> not with a layer below (I don't know how you interconnect your VMs,
> wirefilter/bridges/etc)? You can check using tcpdump on the interface
> batman is using and see if you have any incoming packets of other nodes.
>
> If not, there is most probably something wrong with the interconnect.
>
>>
>> Moreover, I have found a wonderful documention here :
>> http://gitorious.org/batman-adv-doc. Unfortunatly, it is not maintened
>> since two years. I have also found some papers which describe your
>> protocol, but most of the time, the paper are too old or not correct
>> in the protocol description. At this moment, my first source of
>> information is the code. Can you advise me a good paper or
>> documentation on the architecture and features of Batman Advance set
>> apart your twiki.
>
> Well yeah, this documentation is pretty old. I'd suggest to read
>
> http://downloads.open-mesh.org/batman/papers/batman-adv_network_coding.pdf
>
> which has a nice and (quite) up-to-date introduction to batman-adv included.
> Furthermore, we try to keep the Wiki as much up to date as possible, if there
> is something missing feel free to ask.
>
> Cheers,
>         Simon
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk/0CvQACgkQrzg/fFk7axYygACfa0uCbrlMDd9bklpcEm3XFnik
> sq4An09exU1zZWlVF27ybLMVFZyFM8FZ
> =gIYi
> -----END PGP SIGNATURE-----
>
