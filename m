Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <1549090.s6anOn0kWk@voltaire>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <23381002.yeogTpj88W@voltaire>
 <OF9D4BC429.65445525-ONC1257DF0.0057EC95-C1257DF0.0058D385@phoenixcontact.com>
 <1549090.s6anOn0kWk@voltaire>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF7D539C0F.7F2029AA-ONC1257DF1.002DB2B5-C1257DF1.002ECBFC@phoenixcontact.com>
Date: Thu, 19 Feb 2015 09:31:08 +0100
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: Antwort: Antwort: Re: Antwort: Re:
 Question concerning batman-adv bug #173 "Mesh packets on bat0"
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

Hi Marek,

the problem seems to be a little bit more complex. Your latest patch does 
not solve the problem.

But I found out, that commenting out the following line in your patch 
makes bat0 work:

slave->master = master;

But as this is the core of "enslaving" a device to a master device, this 
breaks the complete concept behind this I guess (I'm not a skilled kernel 
developer). From this I conclude that there might be a bug somewhere 
deeper in the kernel version I use.  I don't want to give up too early, 
but it looks a little bit as if this "enslaving concept using rtnl" might 
not be usable in these older kernels. What do you think?

Regards,
Andreas

