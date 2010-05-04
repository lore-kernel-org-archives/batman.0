Return-Path: <fboehm@aon.at>
Message-ID: <4BE0014E.8080204@aon.at>
Date: Tue, 04 May 2010 13:13:18 +0200
From: =?ISO-8859-15?Q?Franz_B=F6hm?= <fboehm@aon.at>
MIME-Version: 1.0
References: <201005030828.08856.lindner_marek@yahoo.de>	<20100503204020.GA30927@pandem0nium>
	<201005041021.30248.lindner_marek@yahoo.de>
In-Reply-To: <201005041021.30248.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] sysfs compat
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

Of course you are right Marek. I don't want to stay with 2.6.14 and will 
switch to a kernel >2.6.21 asap.

I wanted to say that it's suddenly more a general problem using chip 
supplier or third party SDK's for embedded systems and being constrained 
to use quite old kernels.

Regards,
Franz


Marek Lindner schrieb:
> Hi,
> 
>> Marek, i've tested your patches with all major kernel releases from 2.6.20
>> to  2.6.33. What i have seen is:
>>
>>  * 2.6.20 fails for various reasons
>>  * 2.6.23 and 2.6.24 show some warnings
>>  * all other kernel versions are fine
>>
>> The warnings for 23 and 24 can be fixed by moving the *_read() defines
>> from  "< 2.6.25" to "< 2.6.23". If you integrate this modification into
>> your patch, you will gain my blessing and my sign-off. :)
> 
> 
> thanks for testing. I followed your suggestion before pushing the patches. :)
> 
> Since 2.6.20 does not work at this point I removed it from the list of 
> supported kernel versions. Unfortunately, many embedded system vendors do not 
> bother to bring their drivers upstream and instead, publish "code blobs" 
> limited to an old linux version. So, it makes sense for us to offer support for 
> older versions as well. We could remove old versions if the effort is getting 
> too high (as we just did with 2.6.20).
> 
> @Franz: I know you are stuck at 2.6.14 or something similar with your Atheros 
> system but I don't think it is feasible for us to "go down" that far (unless 
> you find a way). It might be easier to try pushing your Atheros beyong the 
> current 2.6.21 minimum.
> 
> Regards,
> Marek
> 
