Return-Path: <hwhilse@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Mar 2016 10:38:55 +0100
From: Hans-Werner Hilse <hwhilse@gmail.com>
In-Reply-To: <2352013.EmfB5eiPMC@bentobox>
References: <1458551033-8734-1-git-send-email-hwhilse@gmail.com>
 <1458551033-8734-2-git-send-email-hwhilse@gmail.com>
 <2352013.EmfB5eiPMC@bentobox>
Message-ID: <e5bc47fb3a536ddda2923e4d85773cb4@hilses.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] alfred: implement TCP support for
 server-to-server communication
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

Hi,

Am 2016-03-21 10:13, schrieb Sven Eckelmann:
>> +int connect_tcp(struct interface *interface, const struct in6_addr 
>> *dest)
>> +{
>> [...]
>> +}
>> +
> 
> Wouldn't this hang for a while and make the alfred server 
> "unresponsive"
> when the remote is not reachable at this moment?.

Yes, it most definitely would, you're right.

If the route I'm following is generally right, I think I'll work on this 
part (*that* I can make into a different commit). The connect() can be 
made non-blocking, and I would add the socket and the request to send to 
a list (possibly using the transaction list that already exists right 
now).

-hwh
