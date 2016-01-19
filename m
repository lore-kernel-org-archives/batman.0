Return-Path: <jerome.gries@sfr.fr>
From: =?iso-8859-1?b?Suly9G1l?= GRIES <jerome.gries@sfr.fr>
Message-ID: <569E3B82.2060102@sfr.fr>
Date: Tue, 19 Jan 2016 14:34:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Question about sliding windows in Batman-adv 2015.0
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello everybody (thx to Marek Lindner for the answer)

My name is Jérôme, i'm a French student  in informatics and networks, 
for a project i use BATMAN ( i use it with raspberry Pi in cars).

I would like to change the duration of the sliding windows, i understand 
that the duration of the sliding windows is equals to 128*intervall it 
(intervall beetween every hello packets)

So normally the sliding windows is equals to 128 seconds because the 
interval is 1s in default mode.

I would like to change  the code to change this duration but not just 
with the interval it value but directly with the 128. Because when i use 
this protocol in a mobile environment like cars this value is to high, 
and i would like to reduce in something like sliding windows duration = 
30*5(=interval it which i can change easily).


Could you tell me where i can find something like that in the code :

#define _timeslidingwindows 128



Thank you and have a nice day.

Jérôme Gries




