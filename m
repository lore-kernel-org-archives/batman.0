Return-Path: <tracer@robotech.de>
Message-ID: <4E5E69DB.5060007@robotech.de>
Date: Wed, 31 Aug 2011 19:05:31 +0200
From: Tobias <tracer@robotech.de>
MIME-Version: 1.0
References: <4E5D69E3.30403@robotech.de>
	<CAKeC-QGag_c+g93MbiJWL9HB3iOczbfbatYUAA1wEEFSyvyd2g@mail.gmail.com>
	<20110831160712.GC25149@ritirata.org>
	<201108311816.23147.lindner_marek@yahoo.de>
	<20110831161833.GD25149@ritirata.org>
In-Reply-To: <20110831161833.GD25149@ritirata.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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

Am 31.08.2011 18:18, schrieb Antonio Quartulli:
> On Wed, Aug 31, 2011 at 06:16:22PM +0200, Marek Lindner wrote:
>> On Wednesday, August 31, 2011 18:07:13 Antonio Quartulli wrote:
>>> Could it be a TT problem? Please, try to enable TT related log only (using
>>> "batctl ll x", I can't remember the correct x value) and copy/paste the
>>> output of "batctl l" during the blackout time to
>>> the moment when everything restart to work.
>> It is honorable that you want to take the blame but 2011.2.0 does not have the
>> tt patches yet.  ;-)
> Ops, sorry! I always confuse the release numbers :-)
> (phew)
>
> cheers,
> Antonio

Sorry, I mixed the versions i installed. I have the problems with 
2011.3.0. Before - I tried with 2011.2.0 but when i flashed the nodes i 
took 2011.3.0.

So i tried activating the log (batctl ll 4) but it its way too much to 
keep that running for more than a few seconds. If you relly need the 
complete log i have to setup a syslog-server to store that.

A short snippet:
[     25706] Received TT_RESPONSE from bat53 for ttvn 1 t_size: 1 [F]
[     25706] Deleting global tt entry 04:11:80:db:48:c8 (via 
0a:18:84:1e:f6:05): originator time out
[     25706] Creating new global tt entry: 00:02:81:b9:4c:c8 (via 
0a:18:84:1e:f6:05)
[     25707] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 20405 
num_changes: 0)
[     25707] Sending TT_REQUEST to bat53 via bat51 [F]
[     25707] Received TT_RESPONSE from bat53 for ttvn 1 t_size: 1 [F]
[     25707] Deleting global tt entry 00:02:81:b9:4c:c8 (via 
0a:18:84:1e:f6:05): originator time out
[     25707] Creating new global tt entry: 18:84:1e:f6:05:01 (via 
0a:18:84:1e:f6:05)
[     25707] TT inconsistency for 0a:18:84:1e:f6:05. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 51609 last_crc: 19671 
num_changes: 0)
[     25707] Sending TT_REQUEST to bat53 via bat51 [F]
[     25707] Received TT_RESPONSE from bat53 for ttvn 1 t_size: 1 [F]
[     25707] Deleting global tt entry 18:84:1e:f6:05:01 (via 
0a:18:84:1e:f6:05): originator time out
[     25707] Creating new global tt entry: 04:11:80:e4:a8:c8 (via 
0a:18:84:1e:f6:05)
[     25708] TT inconsistency for 0a:18:84:26:35:9d. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 1 crc: 40594 last_crc: 53273 
num_changes: 0)

Tobias

